class ConvertRoleStringToIntegerInUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role_integer, :integer

    User.reset_column_information
    User.find_each do |user|
      case user.role
      when 'guest'
        user.update_column(:role_integer, 0)
      when 'owner'
        user.update_column(:role_integer, 1)
      when 'dealer'
        user.update_column(:role_integer, 2)
      when 'admin'
        user.update_column(:role_integer, 3)
      else
        user.update_column(:role_integer, 0) # default to guest if unknown
      end
    end

    remove_column :users, :role
    rename_column :users, :role_integer, :role
  end

  def down
  unless column_exists?(:users, :role_string)
    add_column :users, :role_string, :string
  end

  User.reset_column_information
  User.find_each do |user|
    case user.role
    when 0
      user.update_column(:role_string, 'guest')
    when 1
      user.update_column(:role_string, 'owner')
    when 2
      user.update_column(:role_string, 'dealer')
    when 3
      user.update_column(:role_string, 'admin')
    end
  end

  remove_column :users, :role
  rename_column :users, :role_string, :role
end

end
