class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :property, null: false, foreign_key: true

      t.string :main_image
      t.string :thumbnail

      # Additional images (optional, scalable fields)
      (1..10).each do |i|
        t.string :"image#{i}_url"
      end

      t.timestamps
    end
  end
end
