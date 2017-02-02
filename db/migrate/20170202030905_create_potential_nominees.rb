class CreatePotentialNominees < ActiveRecord::Migration
  def change
    create_table :potential_nominees do |t|
      t.references :person, index: true, foreign_key: true
      t.references :award, index: true, foreign_key: true
      t.references :play, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
