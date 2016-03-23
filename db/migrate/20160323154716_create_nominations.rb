class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|
      t.integer :user_id
      t.integer :award_id
      t.integer :theater_id
      t.integer :play_id
      t.string :nominee
      t.string :role
      t.boolean :open
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
