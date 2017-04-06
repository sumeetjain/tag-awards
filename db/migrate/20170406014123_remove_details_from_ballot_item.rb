class RemoveDetailsFromBallotItem < ActiveRecord::Migration
  def change
    remove_column :ballot_items, :play_id, :integer
    remove_column :ballot_items, :nominee, :string
    remove_column :ballot_items, :role, :string
    remove_column :ballot_items, :approved, :boolean
    remove_column :ballot_items, :weight, :integer
  end
end
