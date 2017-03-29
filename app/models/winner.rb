class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item



	# returns Hash of award -> ballot_item winner
	def calculate_winners
		winnerslist = {}
		Award.all.each do |award|
			scores = getScoresForBallotItems(award)
			winnerslist[award] = getWinner(scores)
		end
		return winnerslist
	end



	private

	# returns hash of ballot_item AR-> score integer
	def getScoresForBallotItems(award)
		ballot_item_scores = {}
		maxscore = getMaxScore(award)
		award.ballot_items.all.each do |ballot_item|
			ballot_item_scores[ballot_item] = calculateBallotItemScore(ballot_item,maxscore)
		end
		return ballot_item_scores
	end

	#returns integer
	def calculateBallotItemScore(ballot_item,maxscore)
		ballot_item_score = 0
		ballot_item.votes.each do |vote|
			debugger
			ballot_item_score += calculateVoteScore(vote,maxscore)
		end
		return ballot_item_score
	end

	# returns an integer
	def calculateVoteScore(vote,maxscore)
		vote_user = vote.user
		vote_ballot_item_id = vote.ballot_item.id

		user_viewings = vote_user.viewings.pluck("play_id")
		ballot_items_for_award = vote.ballot_item.award.ballot_items.pluck("play_id")
		ballot_items_viewed = user_viewings & ballot_items_for_award

		if ballot_items_viewed.length == maxscore
			score = maxscore
		elsif ballot_items_viewed.length < maxscore
			score = ballot_items_viewed.length
		end
		debugger
		unless ballot_items_viewed.include?(vote_ballot_item_id)
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

end
