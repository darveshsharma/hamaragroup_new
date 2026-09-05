class AddRazorpayOrderIdToMembershipPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :membership_payments, :razorpay_order_id, :string
  end
end
