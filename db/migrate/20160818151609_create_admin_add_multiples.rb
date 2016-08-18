class CreateAdminAddMultiples < ActiveRecord::Migration
  def change
    create_table :admin_add_multiples do |t|

      t.timestamps null: false
    end
  end
end
