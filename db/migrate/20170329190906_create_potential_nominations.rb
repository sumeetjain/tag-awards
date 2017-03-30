class CreatePotentialNominations < ActiveRecord::Migration
  def change
    create_table :potential_nominations do |t|
      t.integer :role_id
      t.integer :award_id

      t.timestamps null: false
    end
  end
end
