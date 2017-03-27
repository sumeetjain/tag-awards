class CreatePotentialNominations < ActiveRecord::Migration
  def change
    create_table :potential_nominations do |t|
      t.integer :artist_id
      t.integer :award_id
      t.integer :play_id

      t.timestamps null: false
    end
  end
end
