class Artist < ActiveRecord::Base
  has_and_belongs_to_many :plays
  has_and_belongs_to_many :play_by_current_years

  def play_for_current_year_ids
    [1]
  end
end
