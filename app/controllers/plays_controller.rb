class PlaysController < ApplicationController

def new
  redirect_to "/theaters/new"
end

def create
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