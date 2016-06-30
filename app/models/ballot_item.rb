class BallotItem < ActiveRecord::Base

  belongs_to :award
  belongs_to :play
  has_many :votes

  def theater_name
    play.theater.name
  end

  def show
    play.title
  end

end
