class Play < ActiveRecord::Base
  has_and_belongs_to_many :artists
  belongs_to :theater
  belongs_to :voting_period

  #has_many :nominations
  has_many :viewings
  has_many :ballot_items

  has_many :potential_nominations

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

end
