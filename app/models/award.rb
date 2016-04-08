class Award < ActiveRecord::Base
  has_many :nominations
  has_many :ballot_items
  def label
    self.award_name.split.join.downcase
  end
end
