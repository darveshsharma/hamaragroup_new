class CreateDocumentAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :document_accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.references :document, null: false, foreign_key: true
      t.string :payment_status
      t.string :payment_id
      t.decimal :amount

      t.timestamps
    end
  end
end
