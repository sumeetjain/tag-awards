# Contains methods related to User viewings.
module UserViewings
  # Returns a list of the user's viewings for the active voting period
  def current_voting_period_viewings
    viewings.where( play: Play.where( voting_period: VotingPeriod.where(active: true) ) )
  end

  # Returns true if the user has viewed the play and false otherwise
  def has_viewed? play
    !viewings.where(play: play).empty?
  end

  # Takes an array of play ids and creates viewings for these plays using
  # one SQL statement
  def insert_viewings play_ids
    time = Time.now.to_s(:db)
    inserts = play_ids.map { |id| "(#{self.id}, #{id}, '#{time}', '#{time}')" }
    sql = "INSERT INTO viewings (user_id, play_id, created_at, updated_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
