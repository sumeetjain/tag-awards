class PlaysController < ApplicationController

def new
  redirect_to "/theaters/new"
end

def create
  binding.pry
  #@theater = Theater.find_by_id(params[:id])
  #@play = Play.new(title: params[:title], params[:play])
  #binding.pry
  #@theater = Theater.find_by_id(params[:id])
  #@play = Play.new(title: params[:title])
  #@play.save
  redirect_to "/users/home"
end


end