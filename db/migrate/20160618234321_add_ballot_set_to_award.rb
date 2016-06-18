class AddBallotSetToAward < ActiveRecord::Migration
  def change
    add_column :awards, :ballot_set, :boolean, default: false
    add_index :awards, :ballot_set
  end
end
