class PlaysController < ApplicationController

def new
  # @plays = Play.all
  redirect_to "/theaters/new"
end

def create
  @theater = Theater.new(name: params[:name])
  @theater.save
  redirect_to "/users/home"
end


end