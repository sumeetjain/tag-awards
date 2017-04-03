class RemoveRoleIdFromPotentialNominations < ActiveRecord::Migration
  def up
    remove_column :potential_nominations, :role_id
  end

  def down
    add_column :potential_nominations, :role_id, :integer
  end
end
