class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => params[:id]})
    render "index"
  end

  def new
    @plays = Play.all
  end

  def edit
    @viewing = Viewing.find_by_id(params[:id])
  end

  def delete
    @viewing = Viewing.find_by_id(params[:id])    
  end
  
end