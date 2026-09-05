class AddMemberToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :member, :boolean, default: false
  end
end
