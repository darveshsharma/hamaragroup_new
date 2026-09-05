class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :property_type
      t.string :subtype
      t.string :location
      t.decimal :price
      t.string :dispute_status
      t.text :dispute_summary
      t.string :status
      t.boolean :approved
      t.string :mutation_document
      t.string :title_document
      t.string :aksfard_document
      t.string :court_case_document
      t.string :ownership_type
      t.string :total_area
      t.string :jamabandi_year
      t.text :boundaries

      t.timestamps
    end
  end
end
