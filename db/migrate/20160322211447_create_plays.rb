class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :title
      t.integer :theater_id

      t.timestamps null: false
    end
  end
end
