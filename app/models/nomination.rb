class Nomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :award
  belongs_to :play

end
