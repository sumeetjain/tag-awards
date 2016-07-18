class SetCurrentVotingPeriod < ActiveRecord::Migration
  def up
    VotingPeriod.create(year: 2016, ballot_status: "final_voting_started")
  end

  def down
  end
end
