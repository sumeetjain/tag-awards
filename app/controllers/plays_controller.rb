class PlaysController < ApplicationController

def new
  @plays = Play.all
  @theaters = Theater.all
  @theater = Theater.new
end

def create_theater
  if params[:theater][:id] != ""
    @theater = Theater.find_by_id(params[:theater][:id])
  else
    @theater = Theater.new(name: params[:theater][:name])
    @theater.save
  end
  @theater.plays.create(title: params[:theater][:play][:title])
  redirect_to "/users/home"
end

def create_play
  @play = Play.new
    params[:play].each do |k, v|
      @play.assign_attributes(k => v)
    end
  binding.pry

    #@theater = Theater.find_by_id(params[:id])
  #theater_id = params[:play][:theater_id].to_i
  #@play = Play.new(title: params["play_title"], theater_id: theater_id)
    #@play.assign_attributes(params[:play])
  #binding.pry
  #@play.save
    #@theater = Theater.find_by_id(params[:id])
    #@play = Play.new(title: params[:title])
    #@play.save
  redirect_to "/users/home"

end


end