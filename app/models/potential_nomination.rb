class PotentialNomination < ActiveRecord::Base
  has_many :roles
  belongs_to :award
  has_many :nominations

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }
end
