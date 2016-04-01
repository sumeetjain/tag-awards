class CreateBallotItems < ActiveRecord::Migration
  def change
    create_table :ballot_items do |t|
      t.string :nominee
      t.string :role

      t.timestamps null: false
    end
  end
end
