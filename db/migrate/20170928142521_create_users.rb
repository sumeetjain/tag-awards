class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :full_name
      t.boolean :membership_active
      t.boolean :admin

      t.timestamps
    end
  end
end
