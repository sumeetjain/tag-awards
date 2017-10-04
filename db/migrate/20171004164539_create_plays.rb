class CreatePlays < ActiveRecord::Migration[5.1]
  def change
    create_table :plays do |t|
      t.string :title, null: false
      t.references :voting_period, foreign_key: true, null: false
      t.references :theater, foreign_key: true, null: false

      t.timestamps
    end
    add_index :plays, [:title, :voting_period_id, :theater_id], unique: true
  end
end
