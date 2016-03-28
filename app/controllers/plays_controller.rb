class PlaysController < ApplicationController

def new
  @plays = Play.all
  @theaters = Theater.all
  @theater = Theater.new
end

def create_play
  if params[:theater][:id] != ""
    @theater = Theater.find_by_id(params[:theater][:id])
  else
    @theater = Theater.new(name: params[:theater][:name])
    @theater.save
  end
  @theater.plays.create(title: params[:theater][:play][:title])
  redirect_to "/users/home"
end


end