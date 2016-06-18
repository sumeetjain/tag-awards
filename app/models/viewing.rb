class Viewing < ActiveRecord::Base
  belongs_to :user
  belongs_to :play

  # Returns Integer of the most viewings anyone has.
  def self.most_viewings
    Viewing.select("user_id, count(*) as total_viewings").group("1").order("total_viewings desc").first.total_viewings
  end

  # Returns Integer of the least viewings anyone has.
  def self.least_viewings
    Viewing.select("user_id, count(*) as total_viewings").group("1").order("total_viewings asc").first.total_viewings
  end

  # Returns a Hash with the amount of viewings needed to enter the middle
  # tier (>25%-75%) and the top tier (>75%).
  def self.weighing_thresholds
    range = Viewing.most_viewings - Viewing.least_viewings
    quartile = range / 4

    {middle: quartile, top: quartile * 3}
  end
end
