class Artist < ActiveRecord::Base
  has_many :roles

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }
end
