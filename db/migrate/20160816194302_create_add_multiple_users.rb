class CreateAddMultipleUsers < ActiveRecord::Migration
  def change
    create_table :add_multiple_users do |t|

      t.timestamps null: false
    end
  end
end
