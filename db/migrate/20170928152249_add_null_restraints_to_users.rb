class AddNullRestraintsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :password_digest, false
    change_column_null :users, :username,        false
    change_column_null :users, :email,           false
    change_column_null :users, :full_name,       false
  end
end
