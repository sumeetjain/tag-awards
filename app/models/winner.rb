class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item

	scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }



	# returns Hash of award -> {ballot_item_winner -> score }
	def calculate_winners(year)
		allscores = {}
		Award.all.each do |award|
			scores = getScoresForBallotItems(award,year)
			allscores[award] = scores

			# saveWinner(getWinner(scores))
		end
		return allscores
	end



	private

	# returns hash of ballot_item AR-> score integer
	def getScoresForBallotItems(award,year)
		ballot_item_scores = {}
		ballot_items = award.ballot_items.for_voting_period(year)
		# ballot_items = award.ballot_items
		ballot_items.each do |ballot_item|
			ballot_item_scores[ballot_item] = calculateBallotItemScore(ballot_item)
		end
		return ballot_item_scores.sort_by {|key, value| -value}
	end

	#returns integer
	def calculateBallotItemScore(ballot_item)
		ballot_item_score = 0
		ballot_item.votes.each do |vote|
			score = calculateVoteScore(vote)
			ballot_item_score += score
		end
		return ballot_item_score
	end

	# returns an integer
	def calculateVoteScore(vote)

		award_plays_viewed = awardPlaysViewedByUser(vote)


		maxscore = getMaxScore(vote.ballot_item.award,year)
		if award_plays_viewed.length == maxscore
			score = maxscore
		elsif award_plays_viewed.length < maxscore
			score = award_plays_viewed.length
		end
		unless award_plays_viewed.include?(vote.ballot_item.play_id)
			score = 0
		end

		return score
	end

	#returns array of play ids
	def awardPlaysViewedByUser(vote)
		year = vote.ballot_item.voting_period.year
		
		user_viewings = vote.user.viewings.for_voting_period(year)
		ballot_items_for_award = vote.ballot_item.award.ballot_items.for_voting_period(year)

		plays_user_viewed = user_viewings.pluck("play_id")
		plays_for_award = ballot_items_for_award.pluck("play_id")

		return user_viewings & plays_for_award
	end



	# returns integer of number of unique plays
	def getMaxScore(award,year)
		# maxscore = award.ballot_items.for_voting_period(year).pluck("play_id").uniq.length
		maxscore = award.ballot_items.pluck("play_id").uniq.length
	end

	# returns ballot_item of winner
	def getWinner(scores)
		scores.key(scores.values.max)
	end

	def saveWinner(winner)
		Winner.create(:ballot_item_id=> winner.id)
	end


end
