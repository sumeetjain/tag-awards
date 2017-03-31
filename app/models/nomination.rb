class Nomination < ActiveRecord::Base
  belongs_to :potential_nomination
  accepts_nested_attributes_for :potential_nomination
  belongs_to :user
end
