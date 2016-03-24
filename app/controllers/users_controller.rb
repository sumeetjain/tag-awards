class UsersController < ApplicationController

# write methods named for each action here!

def home
  @plays = Play.all
  @award_categories = Award.all
  binding.pry
  render "home"
end







end