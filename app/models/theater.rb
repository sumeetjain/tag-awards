class Theater < ActiveRecord::Base
  has_many :plays
  accepts_nested_attributes_for :plays
  has_many :viewings, through: :plays
end
