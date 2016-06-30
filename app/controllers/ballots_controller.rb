class BallotsController < ApplicationController

  def new
    @awards = Award.includes(:ballot_items).all
  end

  def create
    current_user.votes.create!(params[:votes])
    redirect_to :root, notice: "Thanks for submitting your final ballot!"
  end

end