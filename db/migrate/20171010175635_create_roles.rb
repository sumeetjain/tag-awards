class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.references :artist, foreign_key: true, null: false
      t.references :play, foreign_key: true, null: false
      t.integer :job, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :roles, [:artist_id, :play_id, :name], unique: true
  end
end
