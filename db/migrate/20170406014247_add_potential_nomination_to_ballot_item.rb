class AddPotentialNominationToBallotItem < ActiveRecord::Migration
  def change
    add_column :ballot_items, :potential_nomination_id, :integer
  end
end
