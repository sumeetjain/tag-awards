class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => params[:id]})
    render "index"
  end

  def new
    @plays = Play.all
  end

  def create
    @viewing = Viewing.new
    @viewing.play_id = params["play_id"]
    @viewing.date = params["date"]
    @viewing.user_id = current_user.id
    binding.pry    
    @viewing.save
  end
  # def edit
  #   @plays = Play.all    
  #   @viewing = Viewing.find_by_id(params[:id])
  # end

  # def delete
  #   @viewing = Viewing.find_by_id(params[:id])    
  # end

end