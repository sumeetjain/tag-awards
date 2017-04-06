class BallotItem < ActiveRecord::Base

  belongs_to :award
  # belongs_to :play
  belongs_to :potential_nomination
  belongs_to :voting_period
  has_many :votes

  #this is a zero or one relationship, will have a winner if it is the winner
  has_one :winner

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  # def theater_name
  #   play.theater.name
  # end

  # def show
  #   play.title
  # end

  def display_name
    potential_nomination.display_name
  end

end
