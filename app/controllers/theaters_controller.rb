class TheatersController < ApplicationController

def new
  @theaters = Theater.all
end

def create
  @theater = Theater.new(name: params[:name])
  @theater.save
  render "users/home"
end


end