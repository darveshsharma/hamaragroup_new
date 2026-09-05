class CreateConsultationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :consultation_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :service_type
      t.text :summary
      t.string :status
      t.string :supporting_document

      t.timestamps
    end
  end
end
