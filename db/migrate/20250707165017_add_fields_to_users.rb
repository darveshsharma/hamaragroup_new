class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string
    add_column :users, :membership_status, :string
    add_column :users, :membership_paid, :boolean
    add_column :users, :membership_paid_at, :datetime
  end
end
