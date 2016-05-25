class AddSecretNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secret_number, :string
    add_index :users, :secret_number, unique: true
  end
end
