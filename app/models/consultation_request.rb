class ConsultationRequest < ApplicationRecord
  belongs_to :user
  belongs_to :property, optional: true

  validates :first_name, :last_name, :email, :phone_number, :description, presence: true

  def full_name
    [first_name, last_name].compact_blank.join(" ")
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id user_id property_id service_type summary status supporting_document
      email full_name phone_number location_of_property description
      created_at updated_at
    ]
  end
end
