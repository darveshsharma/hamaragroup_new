class AllowConsultationRequestsWithoutAProperty < ActiveRecord::Migration[7.1]
  def change
    change_column_null :consultation_requests, :property_id, true
  end
end
