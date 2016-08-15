class DefaultValueForVotingPeriodBallotStatus < ActiveRecord::Migration
  def up
    change_column :voting_periods, :ballot_status, :string, :default => "pending"

    # If there are any existing voting periods with a blank ballot status,
    # set them to be pending periods.
    VotingPeriod.where("ballot_status IS NULL").find_each do |period|
      period.ballot_status = "pending"
      period.save
    end
  end

  def down
    change_column_default :voting_periods, :ballot_status, nil
  end
end
