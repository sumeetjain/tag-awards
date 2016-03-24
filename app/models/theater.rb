class Theater < ActiveRecord::Base
  has_many :plays
  has_many :viewings, through: :plays
end
