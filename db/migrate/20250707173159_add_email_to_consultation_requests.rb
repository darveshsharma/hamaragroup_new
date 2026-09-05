class AddEmailToConsultationRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :consultation_requests, :email, :string
    add_column :consultation_requests, :full_name, :string
    add_column :consultation_requests, :phone_number, :string
    add_column :consultation_requests, :location_of_property, :string
    add_column :consultation_requests, :description, :text

  end
end
