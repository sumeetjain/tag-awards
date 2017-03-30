class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|

      t.timestamps null: false
    end
  end
end
