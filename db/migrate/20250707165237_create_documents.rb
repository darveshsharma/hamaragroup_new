class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :property, null: false, foreign_key: true
      t.string :document_type
      t.string :file_url

      t.timestamps
    end
  end
end
