class CreateTheaters < ActiveRecord::Migration[5.1]
  def change
    create_table :theaters do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :theaters, :name, unique: true
  end
end
