class ViewingsController < ApplicationController

  def index
    @viewings = Viewing.where({"user_id" => current_user.id})
    render "index"
  end

  def new
    @plays = Play.includes(:theater).all
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
    redirect_to "/users/home"
  end

  def edit
    #@plays will eventually be needed for auto-fill feature to help prevent User from being able to type in misspelled plays/theathers
    #@plays = Play.all    
    @viewing = Viewing.find_by_id(params[:id])
  end

  def update
    @user = current_user

    @user.viewing_ids = params[:user] ? params[:user][:viewings] : []

    redirect_to :root, notice: "Viewings saved"
  end

  def delete
    @viewing = Viewing.find_by_id(params[:id])
    @viewing.delete
    redirect_to "/viewings/index"
  end

end