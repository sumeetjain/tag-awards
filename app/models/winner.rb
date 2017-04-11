class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item

	scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }


    # Calculates winners from votes and ballot items for the year given
    #
    # year - String of number year "2017"
    #
	# returns Hash of award AR-> {ballot_item_winner id integer-> score integer}
	def calculate_winners(year)
		allscores = {}
		@helper = WinnerHelper.new(year)
		Award.all.each do |award|
			scores = getScoresForBallotItems(award)
			allscores[award] = scores
		end
		saveScoresAndWinners(allscores)
		return allscores
	end


	# Gets scores saved to ballot items for the year given
    #
    # year - String of number year "2017"
    #
	# returns Hash of award AR-> {ballot_item_winner id integer -> score integer}
	def getAllScores(year)
		allscores = {}
		BallotItem.for_voting_period(year).each do |ballot_item|
			(allscores[ballot_item.award] ||= {})[ballot_item] = ballot_item.score
		end
		allscores.each do |key,value|
			allscores[key] = sortByScore(value)
		end
		return allscores
	end


	private

	# Calculates the scores for the ballot items for a given award
	#
	# award - AR object of an award
	#
	# returns hash of ballot_item id integer-> score integer
	def getScoresForBallotItems(award)
		ballot_item_scores = {}
		@helper.ballotItemsForAward(award).each do |ballot_item_id|
			ballot_item_scores[ballot_item_id] = calculateBallotItemScore(ballot_item_id)
		end
		return sortByScore(ballot_item_scores)
	end

	# Sorts highest scores first
	#
	# ballot_item_scores - hash of ballot_item id integer> score integer
	#
	# returns sorted hash of ballot_item id-> score integer
	def sortByScore(ballot_item_scores)
		sorted_scores = ballot_item_scores.sort_by {|key, value| -value}
		return sorted_scores.to_h
	end

	# Calculates the score of a single ballot item
	#
	# ballot_item_id - integer
	#
	# returns integer for score
	def calculateBallotItemScore(ballot_item_id)
		ballot_item_score = 0
		vote_ids = @helper.votesForBallotItem(ballot_item_id)
		if vote_ids == [] then return 0 end
		vote_ids.each do |vote_id|
			score = calculateVoteScore(vote_id)
			ballot_item_score += score
		end
		return ballot_item_score
	end

	# Calculates a score (or weight) of a single vote based on the vote's user's viewings
	#
	# vote_id - integer
	#
	# returns an integer as the score of the vote
	def calculateVoteScore(vote_id)
		award_plays_viewed = awardPlaysViewedByUser(vote_id)
		maxscore = getMaxScore
		score = getVoteScore(award_plays_viewed.length,maxscore)
		score = checkForViewOfVote(score,vote_id,award_plays_viewed)
		return score
	end

	# Gets a vote's score based on number of user's viewings
	#
	# num_viewed - integer, maxscore - integer
	#
	# returns integer
	def getVoteScore(num_viewed,maxscore)
		if num_viewed == maxscore
			score = maxscore
		elsif num_viewed < maxscore
			score = num_viewed
		end
		return score
	end

	# Checks to make sure the user viewed what they are voting for, returns zero if they didn't
	# 
	# score - integer, vote_id - integer, 
	# 
	# returns integer
	def checkForViewOfVote(score,vote_id,award_plays_viewed)
		votePlay = @helper.playForVote(vote_id)
		unless award_plays_viewed.include?(votePlay)
			score = 0
		end
		return score
	end


	# Checks for which plays in the award category the vote's user has viewed
	# 
	# vote_id - integer
	# 
	# returns array of play ids
	def awardPlaysViewedByUser(vote_id)
		user_id = @helper.userForVote(vote_id)
		plays_user_viewed = @helper.playsForUser(user_id)
		plays_for_award = @helper.playsForAward
		return plays_user_viewed & plays_for_award
	end

	# gets the maximum score for an award for a single vote
	# 
	# returns integer of number of unique plays
	def getMaxScore
		maxscore = @helper.playsForAward.uniq.length
	end

	# Reformats data to be passed into saveWinner and waveScores functions
	# Saves winners to winner table, saves scores to ballot_items
	#
	# allscores - Hash of award AR-> {ballot_item_winner id-> score integer}
	# 
	def saveScoresAndWinners(allscores)
		winners = []
		scores = {}
		allscores.each_value do |ballot_item_scores|
			winners << getWinner(ballot_item_scores)
			ballot_item_scores.each do |ballot_item_id,score|
				scores[ballot_item_id] = {:score => score}
			end
		end
		saveWinners(winners)
		saveScores(scores)
	end

	# Gets highest scoring ballot_item
	#
	# ballot_item_scores - ballot_item_winner id-> score integer
	#
	# returns ballot_item id of winner
	def getWinner(ballot_item_scores)
		ballot_item_scores.key(ballot_item_scores.values.max)
	end

	# save winners for all awards, if winner already in winner table then doesn't add it again
	# 
	# winners - array of ballot_item_ids
	# 
	# Creates new row in winner table for each ballot_item winner
	def saveWinners(winners)
		winners.each do |ballot_item_id|
			Winner.find_or_create_by(:ballot_item_id => ballot_item_id)
		end
	end

	# saved_scores - hash of ballot_item_id integer => {:score => score integer}
	#
	# Updates ballot_items with scores
	def saveScores(saved_scores)
		BallotItem.update(saved_scores.keys,saved_scores.values)
	end


end
