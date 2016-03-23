class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :voter_token, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :weight, :integer
    add_column :users, :admin, :boolean
  end
end
