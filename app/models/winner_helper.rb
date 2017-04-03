class WinnerHelper

	def initialize(year,award)
		@year = year
		@award = award
		@ballot_items = @award.ballot_items.for_voting_period(@year)
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