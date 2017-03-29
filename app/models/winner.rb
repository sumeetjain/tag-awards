class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item




	def calculate_winners

		# for awards.each
		# 	for ballot_item.each
		# 		maxscore =  number of plays
		#			 - this needs to check for duplicate plays
		# 		for vote.each
		# 			user = get user
		#			check viewings for these plays
		# 			if seen all plays, score = maxscore
		# 			if seen some plays, score = number of plays seen
		# 			if voted for play not seen, score = 0
		# 			add score to total score for ballot item voted
		# 		end
		# 	end
		#
		# 	find max score
		# 	
		#end return array of ballot_items

		#add ballot_items to winners


		Award.all.each do |award|
			award.ballot_items.all.each do |ballot_item|


				binding.pry
			end

		end

	end
end
