class PotentialNomination < ActiveRecord::Base
  belongs_to :award
  belongs_to :play
  belongs_to :artist
end
