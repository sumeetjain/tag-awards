class BallotItem < ActiveRecord::Base

  belongs_to :award
  belongs_to :play
  belongs_to :voting_period
  has_many :votes

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  def theater_name
    play.theater.name
  end

  def show
    play.title
  end

end
