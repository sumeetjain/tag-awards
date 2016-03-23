class Award < ActiveRecord::Base
  has_many :nominations
end
