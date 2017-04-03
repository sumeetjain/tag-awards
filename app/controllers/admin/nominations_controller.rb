module Admin
  class NominationsController < Admin::ApplicationController


  	def top_ten
      @theaters = Theater.includes(:plays).all
      @awards = Award.includes(:ballot_items => {play: :theater}).order("awards.award_name asc").all
    end
  end
end
