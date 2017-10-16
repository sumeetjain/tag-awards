class CreateAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :awards do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :award_type, null: false

      t.timestamps
    end
    add_index :awards, :name, unique: true
  end
end
