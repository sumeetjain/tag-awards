class CreateNominatables < ActiveRecord::Migration[5.1]
  def change
    create_table :nominatables do |t|
      t.references :award, foreign_key: true, null: false
      t.integer :nominee_id, null: false
      t.string :nominee_type, null: false
      t.string :display_name, null: false

      t.timestamps
    end
    add_index :nominatables, [:nominee_type, :nominee_id]
    add_index :nominatables, [:nominee_id, :award_id], unique: true
  end
end
