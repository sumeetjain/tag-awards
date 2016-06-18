class Viewing < ActiveRecord::Base
  belongs_to :user
  belongs_to :play

  # Returns Integer of the most viewings anyone has.
  def self.most_shows
    Viewing.select("user_id, count(*) as total_viewings").group("1").order("total_viewings desc").first.total_viewings
  end

  # Returns Integer of the least viewings anyone has.
  def self.least_shows
    Viewing.select("user_id, count(*) as total_viewings").group("1").order("total_viewings asc").first.total_viewings
  end

  # Returns Integer of the most theaters anyone has been to.
  def self.most_theaters
    User.find_by_sql("select user_id, count(*) as theaters_count from (select user_id, plays.theater_id from viewings join plays on viewings.play_id = plays.id group by 1, 2) as user_theaters group by user_id order by theaters_count desc").first.theaters_count
  end

  # Returns Integer of the least theaters anyone has been to.
  def self.least_theaters
    User.find_by_sql("select user_id, count(*) as theaters_count from (select user_id, plays.theater_id from viewings join plays on viewings.play_id = plays.id group by 1, 2) as user_theaters group by user_id order by theaters_count asc").first.theaters_count
  end

  # Returns a Hash with the amount of shows seen needed to enter the middle
  # tier (>25%-75%) and the top tier (>75%).
  def self.shows_weighing_thresholds
    range = Viewing.most_shows - Viewing.least_shows
    quartile = range / 4

    {middle: quartile, top: quartile * 3}
  end

  # Returns a Hash with the amount of theaters visited needed to enter 
  # the middle tier (>25%-75%) and the top tier (>75%).
  def self.theaters_weighing_thresholds
    range = Viewing.most_theaters - Viewing.least_theaters
    quartile = range / 4

    {middle: quartile, top: quartile * 3}
  end
end
