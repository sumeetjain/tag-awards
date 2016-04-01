class Award < ActiveRecord::Base
  has_many :nominations
  has_many :ballot_items
end
