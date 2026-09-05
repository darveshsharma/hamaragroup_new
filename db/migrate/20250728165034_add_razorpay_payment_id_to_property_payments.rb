class AddRazorpayPaymentIdToPropertyPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :property_payments, :razorpay_payment_id, :string
  end
end
