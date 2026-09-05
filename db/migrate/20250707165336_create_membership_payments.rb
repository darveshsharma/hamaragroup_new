class CreateMembershipPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :membership_payments do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.string :payment_status
      t.string :payment_gateway
      t.string :transaction_id
      t.datetime :paid_at

      t.timestamps
    end
  end
end
