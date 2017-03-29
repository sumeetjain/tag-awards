class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item



	##### STill need to make sure we just use 1 year's info

	# returns Hash of award -> ballot_item winner
	def calculate_winners
		allscores = {}
		Award.all.each do |award|
			scores = getScoresForBallotItems(award)
			allscores[award] = scores

			# saveWinner(getWinner(scores))
		end
		return allscores
	end



	private

	# returns hash of ballot_item AR-> score integer
	def getScoresForBallotItems(award)
		ballot_item_scores = {}
		maxscore = getMaxScore(award)
		award.ballot_items.all.each do |ballot_item|
			ballot_item_scores[ballot_item] = calculateBallotItemScore(ballot_item,maxscore)
		end
		return ballot_item_scores.sort_by {|key, value| -value}
	end

	#returns integer
	def calculateBallotItemScore(ballot_item,maxscore)
		ballot_item_score = 0
		ballot_item.votes.each do |vote|
			ballot_item_score += calculateVoteScore(vote,maxscore)
		end
		return ballot_item_score
	end

	# returns an integer
	def calculateVoteScore(vote,maxscore)
		user_viewings = vote.user.viewings.pluck("play_id")
		plays_for_award = vote.ballot_item.award.ballot_items.pluck("play_id")
		award_plays_viewed = user_viewings & plays_for_award

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

	# returns integer of number of unique plays
	def getMaxScore(award)
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
