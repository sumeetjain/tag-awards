class TheatersController < ApplicationController

def new
  @plays = Play.all
  @theaters = Theater.all
  @theater = Theater.new
end

def create
  @theater = Theater.new(name: params[:name])
  @theater.save
  redirect_to "/users/home"
end

end