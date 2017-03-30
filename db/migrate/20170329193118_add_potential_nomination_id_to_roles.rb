class AddPotentialNominationIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :potential_nomination_id, :integer
  end
end
