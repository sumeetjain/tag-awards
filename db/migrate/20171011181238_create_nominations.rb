class CreateNominations < ActiveRecord::Migration[5.1]
  def change
    create_table :nominations do |t|
      t.references :nominatable, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :nominations, [:user_id, :nominatable_id], unique: true
  end
end
