class PrepareTablesForPotentialNominationsPolyRelation < ActiveRecord::Migration
  def up
    add_column :potential_nominations, :nominatable_id,:integer
    add_column :potential_nominations, :nominatable_type, :string
    remove_column :roles, :potential_nomination_id
  end

  def down
    remove_column :potential_nominations, :nominatable_id
    remove_column :potential_nominations, :nominatable_type
    add_column :roles, :potential_nomination_id, :integer
  end
end
