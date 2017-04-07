class WinnerHelper

	# year is integer year such as 2017
	def initialize(year)
		@year_id = year - 2015
		@awardPlayVotes = awardPlayVotes
		@viewedPlays = userViewedPlays
		@userVotes = userVotes
	end

	# query database to return ballot_item id, award id, play id, and vote id for each vote
	#
	# returns table as array 
	def awardPlayVotes
		sql = "SELECT ballot_items.id as ballot_item_id, ballot_items.award_id, ballot_items.play_id, votes.id as vote_id FROM votes 
				JOIN ballot_items ON ballot_items.id=votes.ballot_item_id
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# query database to return user id and  play id for each viewing
	#
	# returns table as array 
	def userViewedPlays
		sql = "SELECT users.id, viewings.play_id FROM users 
				JOIN viewings ON users.id=viewings.user_id"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# query database to return vote id, user id and play id for each vote
	#
	# returns table as array 
	def userVotes
		sql = "SELECT votes.id, votes.user_id, ballot_items.play_id FROM votes 
				JOIN ballot_items ON votes.ballot_item_id = ballot_items.id 
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# gets all ballot items for an award
	# table includes all votes - function returns each ballot item once
	#
	# award - Award AR object
	# 
	# returns array of integers
	def ballotItemsForAward(award)
		@award_id = award.id
		array = []
		@awardPlayVotes.each do |vote|
			if vote['award_id'].to_i == @award_id 
				array << vote['ballot_item_id'].to_i 
			end
		end
		return array.uniq
	end


	# gets all votes for a ballot_item
	#
	# ballot_item_id - integer
	# 
	# returns array of integers
	def votesForBallotItem(ballot_item_id)
		array = []
		@awardPlayVotes.each do |vote|
			if vote['ballot_item_id'].to_i == ballot_item_id
				array << vote['vote_id'].to_i 
			end
		end
		return array
	end

	# gets plays for all ballot items for an award
	# 
	# returns array of integers (play ids)
	def playsForAward
		array = []
		@awardPlayVotes.each do |ballot_item|
			if ballot_item['award_id'].to_i == @award_id 
				array << ballot_item['play_id'].to_i 
			end
		end
		return array.uniq
	end

	# gets all plays a user has viewed
	#
	# user_id - integer
	# 
	# returns array of integers (play ids)
	def playsForUser(user_id)
		array = []
		@viewedPlays.each do |viewing|
			if viewing['id'].to_i == user_id 
				array << viewing['play_id'].to_i 
			end
		end
		return array
	end

	
	# gets user for a vote
	#
	# vote_id - integer
	# 
	# returns integer for user id
	def userForVote(vote_id)
		@userVotes.each do |vote|
			if vote['id'].to_i == vote_id 
				return vote['user_id'].to_i 
			end
		end
	end

	# gets play for a vote
	#
	# vote_id - integer
	# 
	# returns integer for play id
	def playForVote(vote_id)
		@userVotes.each do |vote|
			if vote['id'].to_i == vote_id 
				return vote['play_id'].to_i 
			end
		end
	end

end