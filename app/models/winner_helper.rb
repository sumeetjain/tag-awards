class WinnerHelper

	def initialize(year,award)
		@year_id = determineYearId(year)
		@award_id = award.id
		@awardPlayVotes = awardPlayVotes


		@viewedPlays = userViewedPlays
		@userVotes = userVotes
	end

	#table of ballot items and votes
	def awardPlayVotes
		sql = "SELECT ballot_items.id as ballot_item_id, ballot_items.award_id, ballot_items.play_id, votes.id as vote_id FROM votes 
				JOIN ballot_items ON ballot_items.id=votes.ballot_item_id
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	def ballotItemsForAward
		array = []
		@awardPlayVotes.each do |vote|
			if vote['award_id'].to_i == @award_id 
				array << vote['ballot_item_id'].to_i 
			end
		end
		return array.uniq
	end

	def votesForBallotItem(ballot_item_id)
		array = []
		@awardPlayVotes.each do |vote|
			if vote['ballot_item_id'].to_i == ballot_item_id
				array << vote['vote_id'].to_i 
			end
		end
		return array
	end

	def playsForAward
		array = []
		@awardPlayVotes.each do |ballot_item|
			if ballot_item['award_id'].to_i == @award_id 
				array << ballot_item['play_id'].to_i 
			end
		end
		return array.uniq
	end


	#assume that every year will get an id and no years will be skipped
	def determineYearId(year)
		year - 2015
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

end