class WinnerHelper

	def initialize(year,award)
		@year = year
		@award = award
		@ballot_items = @award.ballot_items.for_voting_period(@year)
		@viewedPlays = userViewedPlays
	end

	# user_id and play_id for all viewings
	# def userViewedPlays
	# 	sql = "SELECT users.id, viewings.play_id FROM users 
	# 			JOIN viewings ON users.id=viewings.user_id"
	# 	# return ActiveRecord::Base.connection.execute(sql)
	# 	return User.find_by_sql(sql)
	# end

	# user_id and play_id for all viewings
	def userViewedPlays
		return User.joins(:viewings).select('users.id,viewings.play_id')
	end

	def playsForUser(user_id)
		return @viewedPlays.where("users.id=#{user_id}").pluck("play_id")
	end

	def year
		return @year
	end

	def award
		return @award
	end


	def ballot_items
		return @ballot_items
	end

	def currentBallotItem(ballot_item)
		@ballot_item = ballot_item
		@votes = ballot_item.votes
	end

	def ballot_item
		return @ballot_item
	end

	def votes 
		return @votes
	end
end