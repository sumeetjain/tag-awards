class AddVotingPeriodsToTables < ActiveRecord::Migration
  def change
    add_reference :ballot_items, :voting_period, index: true
    add_reference :nominations, :voting_period, index: true
    add_reference :plays, :voting_period, index: true

    BallotItem.find_each do |item|
      item.voting_period = VotingPeriod.current
      item.save
    end

    Nomination.find_each do |nom|
      nom.voting_period = VotingPeriod.current
      nom.save
    end

    Play.find_each do |play|
      play.voting_period = VotingPeriod.current
      play.save
    end
  end
end
