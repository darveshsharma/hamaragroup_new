class MembershipPayment < ApplicationRecord
  belongs_to :user
  validates :amount, :payment_status, :payment_gateway, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      user_id
      amount
      payment_status
      payment_gateway
      transaction_id
      paid_at
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

end
