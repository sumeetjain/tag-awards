class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => current_user.id})
    render "index"
  end

  def new
    #@plays will eventually be needed for auto-fill feature to help prevent User from being able to type in misspelled plays/theathers
    #@plays = Play.all        
    @plays = Play.all
  end

  def create
    @viewing = Viewing.new
    @viewing.play_id = params["play_id"]
    @viewing.date = params["date"]
    @viewing.user_id = current_user.id
    @viewing.save
  end

  def edit
    #@plays will eventually be needed for auto-fill feature to help prevent User from being able to type in misspelled plays/theathers
    #@plays = Play.all    
    @viewing = Viewing.find_by_id(params[:id])
  end

  def update
    @viewing = Viewing.find_by_id(params[:id])
    @viewing.play_id = params["play_id"]
    @viewing.date = params["date"]
    @viewing.save    
  end

  def delete
    @viewing = Viewing.find_by_id(params[:id])
  end

end