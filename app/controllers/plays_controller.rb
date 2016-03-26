class PlaysController < ApplicationController

def new
  @plays = Play.all
  @theaters = Theater.all
end

def create_theater
  @theater = Theater.new(name: params[:name])
  @theater.save
  redirect_to "/users/home"
end

def create_play
  #@theater.play.create(title: params["play_title"])
  #binding.pry
  #@theater = Theater.find_by_id(params[:id])
  theater_id = params[:play][:theater_id].to_i
  @play = Play.new(title: params["play_title"], theater_id: theater_id)
  #@play.assign_attributes(params[:play])
  binding.pry
  @play.save
  #@theater = Theater.find_by_id(params[:id])
  #@play = Play.new(title: params[:title])
  #@play.save
  redirect_to "/users/home"

end


end