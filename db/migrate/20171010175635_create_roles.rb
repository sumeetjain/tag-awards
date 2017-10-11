class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.references :artist, foreign_key: true, null: false
      t.references :play, foreign_key: true, null: false
      t.integer :job, null: false
      t.string :character

      t.timestamps
    end
    add_index :roles, [:artist_id, :play_id, :character, :job], unique: true
  end
end
