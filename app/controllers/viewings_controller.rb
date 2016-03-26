class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => current_user.id})
    render "index"
  end

  def new
    @plays = Play.all
  end

#Titled this action 'create_multiple' and left the 'create' that Ryan made so we have both options for adding new viewings and can decide which is preferred. 
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
  # def edit
  #   @plays = Play.all    
  #   @viewing = Viewing.find_by_id(params[:id])
  # end

  # def delete
  #   @viewing = Viewing.find_by_id(params[:id])    
  # end

end