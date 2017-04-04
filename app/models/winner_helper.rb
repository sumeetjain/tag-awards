class WinnerHelper

	def initialize(year,award)
		@year = year
		@award = award
		@ballot_items = @award.ballot_items.for_voting_period(@year)
		@viewedPlays = userViewedPlays
	end

	#user_id and play_id for all viewings
	def userViewedPlays
		sql = "SELECT users.id, viewings.play_id FROM users 
				JOIN viewings ON users.id=viewings.user_id"
		# return ActiveRecord::Base.connection.execute(sql)
		return User.find_by_sql(sql)
	end

	#vote_id and user_id for all votes
	# def voteUsers
	# 	sql = "SELECT users.id, viewings.play_id FROM users 
	# 			JOIN viewings ON users.id=viewings.user_id"
	# 	return ActiveRecord::Base.connection.execute(sql)
	# end


	def playsForUser(user_id)
		array = []
		@viewedPlays.each do |user|
			if user_id = user.id then array << user.play_id end
		end
		# return @viewedPlays.where(id=user_id).pluck("play_id")
		return array
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