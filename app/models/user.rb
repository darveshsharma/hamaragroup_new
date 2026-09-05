class User < ApplicationRecord
  has_many :consultation_requests, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :membership_payments, dependent: :destroy
  has_many :property_payments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { owner: 0, dealer: 1, lawyer: 2, buyer: 3, admin: 4 }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :owner
  end

  def member?
    member == true
  end

  def active_member?
    membership_paid? || member?
  end

  def admin?
    role == "admin"
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[properties consultation_requests membership_payments property_payments]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id email role member membership_paid membership_paid_at
      created_at updated_at
    ]
  end
end
