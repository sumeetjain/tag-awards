class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item

	scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }



	# returns Hash of award AR-> {ballot_item_winner AR-> score integer}
	def calculate_winners(year)
		allscores = {}
		Award.all.each do |award|
			@helper = WinnerHelper.new(year,award)
			scores = getScoresForBallotItems
			allscores[award] = scores

			# saveWinner(getWinner(scores))
		end
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

	# returns hash of ballot_item AR-> score integer
	def getScoresForBallotItems
		ballot_item_scores = {}
		@helper.ballot_items.each do |ballot_item|
			@helper.currentBallotItem(ballot_item)
			ballot_item_scores[ballot_item] = calculateBallotItemScore
		end
		return sortByScore(ballot_item_scores)
	end

	def sortByScore(ballot_item_scores)
		sorted_scores = ballot_item_scores.sort_by {|key, value| -value}
		return sorted_scores.to_h
	end

	#returns integer
	def calculateBallotItemScore
		ballot_item_score = 0
		@helper.votes.each do |vote|
			score = calculateVoteScore(vote)
			ballot_item_score += score
		end
		saveScore(@helper.ballot_item,ballot_item_score)
		return ballot_item_score
	end

	# returns an integer
	def calculateVoteScore(vote)
		award_plays_viewed = awardPlaysViewedByUser(vote)
		maxscore = getMaxScore
		score = getVoteScore(award_plays_viewed.length,maxscore)
		score = checkForViewOfVote(score,vote,award_plays_viewed)
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
	def checkForViewOfVote(score,vote,award_plays_viewed)
		unless award_plays_viewed.include?(vote.ballot_item.play_id)
			score = 0
		end
		return score
	end

	#returns array of play ids
	def awardPlaysViewedByUser(vote)
		user_viewings = vote.user.viewings.for_voting_period(@helper.year)

		plays_user_viewed = user_viewings.pluck("play_id")
		plays_for_award = @helper.ballot_items.pluck("play_id")

		return plays_user_viewed & plays_for_award
	end

	# returns integer of number of unique plays
	def getMaxScore
		maxscore = @helper.ballot_items.pluck("play_id").uniq.length
	end

	# returns ballot_item of winner
	def getWinner(scores)
		scores.key(scores.values.max)
	end

	# write to table in database
	def saveWinner(winner)
		Winner.create(:ballot_item_id=> winner.id)
	end

	def saveScore(ballot_item,score)
		BallotItem.update(ballot_item.id, :score => score)
	end


end
