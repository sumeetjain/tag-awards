class AddPotentialNominationIdToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :potential_nomination_id, :integer
  end
end
