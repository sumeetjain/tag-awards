class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => current_user.id})
    render "index"
  end

  def new
    @plays = Play.all
  end

  def create_multiple
    binding.pry
    @viewing = Viewing.new
    params[:play_ids].each do |p|
      @viewing = Viewing.new
      @viewing.play_id = p.to_i
      @viewing.date = params[:date][p]
      @viewing.user_id = current_user.id
      binding.pry
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
  # def edit
  #   @plays = Play.all    
  #   @viewing = Viewing.find_by_id(params[:id])
  # end

  # def delete
  #   @viewing = Viewing.find_by_id(params[:id])    
  # end

end