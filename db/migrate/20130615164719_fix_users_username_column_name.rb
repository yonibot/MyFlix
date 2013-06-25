class FixUsersUsernameColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :full_name
  end
end
