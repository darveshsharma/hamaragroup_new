class DocumentAccessesController < ApplicationController
  before_action :authenticate_user!

  def create
    @property = Property.find(params[:property_id])
    @document = Document.find(params[:document_id])
    amount = (@property.price * 0.01).round(2)

    # Payment gateway integration logic here (example placeholder)
    payment_successful = true # Replace with actual gateway call

    if payment_successful
      DocumentAccess.create!(
        user: current_user,
        property: @property,
        document: @document,
        amount: amount,
        payment_status: "paid",
        payment_gateway: "Stripe", # or PayU etc
        transaction_id: SecureRandom.hex(10),
        paid_at: Time.current
      )

      redirect_to @property, notice: "Payment successful. You can now download the document."
    else
      redirect_to @property, alert: "Payment failed. Please try again."
    end
  end
end
