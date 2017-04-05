class Play < ActiveRecord::Base
  has_many :roles
  belongs_to :theater
  belongs_to :voting_period
  has_many :viewings
  has_many :ballot_items
  has_many :potential_nominations, as: :nominatable

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  def display_name
    "#{title}, #{theater.name}"
  end
end
