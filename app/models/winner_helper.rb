class WinnerHelper

	# year is integer year such as 2017
	def initialize(year)
		@year_id = year - 2015
		@awardBallotItems = awardBallotItems
		@awardVotes = awardVotes
		@viewedPlays = userViewedPlays
		@userVotes = userVotes
		@ballotItemPlays = ballotItemPlays
	end

	# query database to return ballot_item id and award id for each award
	#
	# returns table as array 
	def awardBallotItems
		sql = "SELECT id, award_id FROM ballot_items 
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# query database to return ballot_item id, award id and vote id for each vote
	#
	# returns table as array 
	def awardVotes
		sql = "SELECT ballot_items.id as ballot_item_id, ballot_items.award_id, votes.id as vote_id FROM votes 
				JOIN ballot_items ON ballot_items.id=votes.ballot_item_id
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# query database to return user id and  play id for each viewing
	#
	# returns table as array 
	def userViewedPlays
		sql = "SELECT users.id as user_id, viewings.play_id as play_id FROM users 
				JOIN viewings ON users.id=viewings.user_id"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end

	# query database to return vote id, user id and ballot_item id for each vote
	#
	# returns table as array 
	def userVotes
		sql = "SELECT id as vote_id, user_id, ballot_item_id FROM votes
				JOIN ballot_items ON ballot_items.id=votes.ballot_item_id
				WHERE ballot_items.voting_period_id = #{@year_id}"
		return ActiveRecord::Base.connection.execute(sql).to_a
	end


	def ballotItemPlays
		sql = "SELECT ballot_item.id as ballot_item_id, ballot_item.potential_nomination_id, potenital_nomination.nominatable_id, potenital_nomination.nominatable_type FROM ballot_item 
				JOIN potential_nominations ON ballot_items.potential_nomination_id = potential_nominations.id 
				WHERE ballot_items.voting_period_id = #{@year_id}"
		ballotItemNominatable = ActiveRecord::Base.connection.execute(sql).to_a

		ballotItemNominatable.each do |ballot_item|
			if ballot_item['nominatable_type'] == "Role"
				role_id = ballot_item['nominatable_id']
				play_id = Role.find(role_id).play_id
			else
				play_id = ballot_item['nominatable_id']
			end
			ballot_item['play_id'] = play_id
		end

		return ballotItemNominatable
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
		@awardBallotItems.each do |ballot_item|
			if ballot_item['award_id'].to_i == @award_id 
				array << ballot_item['ballot_item_id'].to_i 
			end
		end
		return array
	end

	# gets all votes for a ballot_item
	#
	# ballot_item_id - integer
	# 
	# returns array of integers
	def votesForBallotItem(ballot_item_id)
		array = []
		@awardVotes.each do |vote|
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
		@awardBallotItems.each do |ballot_item|
			if ballot_item['award_id'].to_i == @award_id 
				array << playForBallotItem(ballot_item['ballot_item_id'])
			end
		end
		return array.uniq
	end


	# gets play id for a ballot item
	#
	# id - ballot_item id integer
	# 
	# returns integer (play id)
	def playForBallotItem(id)
		@ballotItemPlays.each do |ballot_item|
			if ballot_item['ballot_item_id'] == id
				return ballot_item['play_id'].to_i 
			end
		end
	end


	# gets all plays a user has viewed
	#
	# user_id - integer
	# 
	# returns array of integers (play ids)
	def playsForUser(user_id)
		array = []
		@viewedPlays.each do |viewing|
			if viewing['user_id'].to_i == user_id 
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
			if vote['vote_id'].to_i == vote_id 
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
				return playForBallotItem(vote['ballot_item_id'])
			end
		end
	end

end