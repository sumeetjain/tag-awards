class Theater < ActiveRecord::Base
  has_many :plays
  accepts_nested_attributes_for :plays
  has_many :viewings, through: :plays

  def plays_for_current_voting_period
    self.plays.for_voting_period(Time.now.strftime("%Y")).order("title ASC")
  end
end
