class RenameUsersColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :secret_number, :username
  end

  def self.down
    rename_column :users, :username, :secret_number
  end
end
