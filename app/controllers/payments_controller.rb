class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_member
  before_action :set_property
  before_action :set_payment, only: :verify

  def new
    if current_user.property_payments.exists?(property: @property, payment_status: "paid")
      return redirect_to property_path(@property), notice: "You already have document access for this property."
    end

    @amount = document_access_amount
    @payment = current_user.property_payments.create!(
      amount: @amount,
      payment_gateway: "Razorpay",
      payment_status: "created"
    )

    order = razorpay_service.create_order(
      amount: (@amount * 100).to_i,
      receipt: "property_#{@property.id}_#{@payment.id}"
    )

    @payment.update!(razorpay_order_id: order.id)
    @razorpay_order_id = order.id
  end

  def verify
    payment_id = params[:razorpay_payment_id]
    order_id = params[:razorpay_order_id]
    signature = params[:razorpay_signature]

    unless payment_id.present? && order_id.present? && signature.present?
      return render json: { success: false, message: "Missing payment verification details." },
                    status: :unprocessable_entity
    end

    unless @payment.razorpay_order_id == order_id &&
           @payment.user_id == current_user.id &&
           @payment.property_id == @property.id
      return render json: { success: false, message: "Invalid payment." }, status: :unauthorized
    end

    unless razorpay_service.verify_payment_signature(order_id, payment_id, signature)
      return render json: { success: false, message: "Payment verification failed." },
                    status: :unauthorized
    end

    @payment.update!(
      payment_status: "paid",
      transaction_id: payment_id,
      razorpay_payment_id: payment_id,
      paid_at: Time.current
    )

    render json: { success: true, redirect_url: property_path(@property) }
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: "Payment record not found." }, status: :not_found
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def set_payment
    @payment = current_user.property_payments.find(params[:id])
  end

  def document_access_amount
    (@property.price.to_d * 0.01).round(2)
  end

  def razorpay_service
    @razorpay_service ||= RazorpayService.new
  end
end
