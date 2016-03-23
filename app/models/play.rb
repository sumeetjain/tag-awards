class Play < ActiveRecord::Base
  belongs_to :theater

  has_many :nominations
end
