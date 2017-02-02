class PotentialNominee < ActiveRecord::Base
  belongs_to :person
  belongs_to :award
  belongs_to :play
end
