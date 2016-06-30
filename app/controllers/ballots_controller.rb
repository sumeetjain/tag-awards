class BallotsController < ApplicationController

  def new
    @awards = Award.includes(:ballot_items).all
  end

  def create
    if current_user.record_final_ballot(params[:ballot])
      redirect_to :root, notice: "Thanks for submitting your final ballot!"
    end
  end

end