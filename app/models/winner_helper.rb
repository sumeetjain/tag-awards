class WinnerHelper

	def initialize(year,award)
		@year = year
		@award = award
		@ballot_items = @award.ballot_items.for_voting_period(@year)
		@viewedPlays = userViewedPlays
		@userVotes = userVotes
	end

	# user_id and play_id for all viewings
	def userViewedPlays
		sql = "SELECT users.id, viewings.play_id FROM users 
				JOIN viewings ON users.id=viewings.user_id"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	def playsForUser(user_id)
		array = []
		@viewedPlays.each do |viewing|
			if viewing['id'].to_i == user_id 
				array << viewing['play_id'].to_i 
			end
		end
		return array
	end

	#table with vote id, user id, and play id
	def userVotes
		sql = "SELECT votes.id, votes.user_id, ballot_items.play_id FROM votes 
				JOIN ballot_items ON votes.ballot_item_id = ballot_items.id"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	#returns integer
	def userForVote(vote_id)
		@userVotes.each do |vote|
			if vote['id'].to_i == vote_id 
				return vote['user_id'].to_i 
			end
		end
	end

	#returns integer
	def playForVote(vote_id)
		@userVotes.each do |vote|
			if vote['id'].to_i == vote_id 
				return vote['play_id'].to_i 
			end
		end
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