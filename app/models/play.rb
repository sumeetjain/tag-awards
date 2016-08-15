class Play < ActiveRecord::Base
  belongs_to :theater
  belongs_to :voting_period

  #has_many :nominations
  has_many :viewings
  has_many :ballot_items

end
