class AddApprovedAndWeightToBallotItem < ActiveRecord::Migration
  def change
    add_column :ballot_items, :approved, :boolean
    add_column :ballot_items, :weight, :integer
  end
end
