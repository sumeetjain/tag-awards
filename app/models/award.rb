class Award < ActiveRecord::Base
  has_many :nominations
  has_many :ballot_items
  #label converts award_name to Courtney's CSS label system
  #example: "Best Musical" will become "bestmusical"
  def label
    self.award_name.split.join.downcase
  end
end
