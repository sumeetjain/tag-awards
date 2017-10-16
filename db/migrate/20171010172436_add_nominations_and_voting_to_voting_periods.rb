class AddNominationsAndVotingToVotingPeriods < ActiveRecord::Migration[5.1]
  def change
    add_column :voting_periods, :nominations_active, :boolean,
               default: false, null: false
    add_column :voting_periods, :voting_active, :boolean,
               default: false, null: false
  end
end
