class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :artist_id
      t.integer :play_id
      t.string :job
      t.string :character
      t.integer :voting_period_id

      t.timestamps null: false
    end
  end
end
