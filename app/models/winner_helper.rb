class WinnerHelper

	def initialize(year,award)
		@year = year
		@award = award
		@ballot_items = @award.ballot_items.for_voting_period(@year)
		@viewedPlays = userViewedPlays
		@userVotes = userVotes
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

	# vote_id and user_id table
	def userVotes
		userVotesPlays = Vote.joins("JOIN ballot_items ON votes.ballot_item_id = ballot_items.id")
							.select('votes.id,votes.user_id,ballot_items.play_id')
		return userVotesPlays
	end

	#returns integer
	def userForVote(vote_id)
		user_id = @userVotes.where("votes.id=#{vote_id}").pluck("user_id")
		return user_id[0]
	end

	#returns integer
	def playForVote(vote_id)
		play_id = @userVotes.where("votes.id=#{vote_id}").pluck("play_id")
		return play_id[0]
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