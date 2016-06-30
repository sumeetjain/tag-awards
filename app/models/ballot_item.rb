class BallotItem < ActiveRecord::Base

belongs_to :award
belongs_to :play
has_many :votes


end
