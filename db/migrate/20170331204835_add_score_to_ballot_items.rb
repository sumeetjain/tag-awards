class AddScoreToBallotItems < ActiveRecord::Migration
  def change
    add_column :ballot_items, :score, :integer
  end
end
