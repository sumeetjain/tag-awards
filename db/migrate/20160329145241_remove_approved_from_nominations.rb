class RemoveApprovedFromNominations < ActiveRecord::Migration
  def change
    remove_column :nominations, :approved, :boolean
  end
end
