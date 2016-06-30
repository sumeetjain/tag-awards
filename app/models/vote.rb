class Vote < ActiveRecord::Base
  belongs_to :ballot_item
  belongs_to :user
end
