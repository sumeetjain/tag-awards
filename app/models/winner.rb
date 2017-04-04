class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item

	scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }



	# returns Hash of award AR-> {ballot_item_winner AR-> score integer}
	def calculate_winners(year)
		@saved_scores = {}
		allscores = {}
		winners = []
		@helper = WinnerHelper.new(year)
		Award.all.each do |award|
			# @helper = WinnerHelper.new(year,award)
			scores = getScoresForBallotItems(award)
			allscores[award] = scores

			winners << getWinner(scores)
		end
		saveScores
		saveWinners(winners)
		return allscores
	end

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

	# returns hash of ballot_item id-> score integer
	def getScoresForBallotItems(award)
		ballot_item_scores = {}
		@helper.ballotItemsForAward(award).each do |ballot_item_id|
			ballot_item_scores[ballot_item_id] = calculateBallotItemScore(ballot_item_id)
		end
		return sortByScore(ballot_item_scores)
	end

	def sortByScore(ballot_item_scores)
		sorted_scores = ballot_item_scores.sort_by {|key, value| -value}
		return sorted_scores.to_h
	end

	#returns integer
	def calculateBallotItemScore(ballot_item_id)
		ballot_item_score = 0
		vote_ids = @helper.votesForBallotItem(ballot_item_id)
		vote_ids.each do |vote_id|
			score = calculateVoteScore(vote_id)
			ballot_item_score += score
		end
		@saved_scores[ballot_item_id] = {:score => ballot_item_score}
		return ballot_item_score
	end

	# returns an integer
	def calculateVoteScore(vote_id)
		award_plays_viewed = awardPlaysViewedByUser(vote_id)
		maxscore = getMaxScore
		score = getVoteScore(award_plays_viewed.length,maxscore)
		score = checkForViewOfVote(score,vote_id,award_plays_viewed)
		return score
	end

	# num_viewed - integer
	# maxscore - integer
	# returns integer
	def getVoteScore(num_viewed,maxscore)
		if num_viewed == maxscore
			score = maxscore
		elsif num_viewed < maxscore
			score = num_viewed
		end
		return score
	end

	#returns integer
	def checkForViewOfVote(score,vote_id,award_plays_viewed)
		votePlay = @helper.playForVote(vote_id)
		unless award_plays_viewed.include?(votePlay)
			score = 0
		end
		return score
	end

	#returns array of play ids
	def awardPlaysViewedByUser(vote_id)
		user_id = @helper.userForVote(vote_id)
		plays_user_viewed = @helper.playsForUser(user_id)
		plays_for_award = @helper.playsForAward

		return plays_user_viewed & plays_for_award
	end

	# returns integer of number of unique plays
	def getMaxScore
		maxscore = @helper.playsForAward.uniq.length
	end

	# returns ballot_item id of winner
	def getWinner(scores)
		scores.key(scores.values.max)
	end

	# write to table in database
	def saveWinners(winners)
		winners.each do |ballot_item_id|
			Winner.find_or_create_by(:ballot_item_id => ballot_item_id)
		end
	end

	def saveScores
		BallotItem.update(@saved_scores.keys,@saved_scores.values)
	end


end
