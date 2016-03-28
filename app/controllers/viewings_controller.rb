class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => current_user.id})
    render "index"
  end

  def new
    #@plays will eventually be needed for auto-fill feature to help prevent User from being able to type in misspelled plays/theathers
    #@plays = Play.all        
    @plays = Play.all
    @seen_plays = current_user.plays
    # This is to get a collection of play objects that the current user has not seen. TODO: refactor or clean up with Association methods.
    seen_plays_ids = []
      @seen_plays.each do |p|
        seen_plays_ids << p.id
      end
    @unseen_plays = Play.where.not(id: seen_plays_ids)
    # The below is required because a new theater object must be passed to the view in order to make the form_for that gets rendered if a user wants to create a new play and/or theater.
    @theater = Theater.new
    @theaters = Theater.all
  end

# Titled this action 'create_multiple' and left the 'create' that Ryan made so we have both options for adding new viewings and can decide which is preferred. 
  def create_multiple
    params[:play_ids].each do |p|
      @viewing = Viewing.new
      @viewing.play_id = p.to_i
      @viewing.date = params[:date][p]
      @viewing.user_id = current_user.id
      @viewing.save
    end
    redirect_to "/users/home"
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

  # def delete
  #   @viewing = Viewing.find_by_id(params[:id])    
  # end

end