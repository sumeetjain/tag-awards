class RemoveVotingPeriodIdFromRoles < ActiveRecord::Migration
  def up
    remove_column :roles, :voting_period_id
  end

  def down
    add_column :roles, :voting_period_id, :integer
  end
end
