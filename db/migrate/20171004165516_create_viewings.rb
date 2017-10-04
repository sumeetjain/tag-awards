class CreateViewings < ActiveRecord::Migration[5.1]
  def change
    create_table :viewings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :play, foreign_key: true, null: false

      t.timestamps
    end
    add_index :viewings, [:user_id, :play_id], unique: true
  end
end
