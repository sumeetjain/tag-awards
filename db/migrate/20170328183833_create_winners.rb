class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :ballot_item_id

      t.timestamps null: false
    end
  end
end
