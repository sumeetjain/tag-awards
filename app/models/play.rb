class Play < ActiveRecord::Base
  belongs_to :theater

  #has_many :nominations
  has_many :viewings
  has_many :ballot_items
end
