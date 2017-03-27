class PotentialNomination < ActiveRecord::Base
  belongs_to :award
  belongs_to :play
  belongs_to :artist

  accepts_nested_attributes_for :play
  scope :play_for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }
end
