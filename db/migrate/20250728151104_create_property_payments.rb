class CreatePropertyPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :property_payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.integer :amount
      t.string :payment_gateway
      t.string :transaction_id
      t.string :payment_status
      t.string :razorpay_order_id
      t.datetime :paid_at

      t.timestamps
    end
  end
end
