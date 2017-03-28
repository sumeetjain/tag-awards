class Winner < ActiveRecord::Base
	belongs_to :ballot_item

	has_one :voting_period, through: :ballot_item
	has_one :award, through: :ballot_item

	has_many :votes, through: :ballot_item




	def calculate_winners
	end
end
