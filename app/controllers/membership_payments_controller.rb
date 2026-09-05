class MembershipPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_member, only: %i[new create]

  MEMBERSHIP_AMOUNT = 10_000.to_d

  def new
    @membership_payment = current_user.membership_payments.build(
      amount: MEMBERSHIP_AMOUNT,
      payment_gateway: "Razorpay"
    )
  end

  def create
    payment = current_user.membership_payments.create!(
      amount: MEMBERSHIP_AMOUNT,
      payment_gateway: "Razorpay",
      payment_status: "pending"
    )

    order = razorpay_service.create_order(
      amount: (MEMBERSHIP_AMOUNT * 100).to_i,
      receipt: "membership_#{payment.id}"
    )

    payment.update!(razorpay_order_id: order.id)

    render json: {
      id: order.id,
      amount: order.amount,
      currency: order.currency
    }
  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, error: e.record.errors.full_messages.to_sentence },
           status: :unprocessable_entity
  end

  def verify
    payment_id = params[:razorpay_payment_id]
    order_id = params[:razorpay_order_id]
    signature = params[:razorpay_signature]

    payment = current_user.membership_payments.find_by(razorpay_order_id: order_id)

    unless payment && payment.amount == MEMBERSHIP_AMOUNT
      return render json: { success: false, error: "Invalid membership payment." },
                    status: :unauthorized
    end

    unless razorpay_service.verify_payment_signature(order_id, payment_id, signature)
      return render json: { success: false, error: "Invalid payment signature." },
                    status: :unauthorized
    end

    User.transaction do
      payment.update!(
        payment_status: "success",
        transaction_id: payment_id,
        paid_at: Time.current
      )

      current_user.update!(
        membership_status: "active",
        membership_paid: true,
        membership_paid_at: Time.current,
        member: true
      )
    end

    MembershipEmailJob.perform_later(current_user.id, payment.id)

    render json: { success: true, redirect_url: root_path }
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, error: "Payment not found." }, status: :not_found
  end

  private

  def redirect_if_member
    return unless current_user.active_member?

    redirect_to root_path, notice: "You are already a member."
  end

  def razorpay_service
    @razorpay_service ||= RazorpayService.new
  end
end
