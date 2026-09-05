class DocumentAccess < ApplicationRecord
  belongs_to :user
  belongs_to :property
  belongs_to :document

  validates :amount, :payment_status, :payment_gateway, presence: true

  def paid?
    payment_status == 'paid'
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id user_id property_id document_id amount payment_status
      payment_gateway transaction_id paid_at created_at updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user property document]
  end
end
