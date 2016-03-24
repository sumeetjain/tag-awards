class UsersController < ApplicationController

# write methods named for each action here!

def home
  #@viewings = Viewing.where(params[:voter_token] => self.user.voter_token) #or something...ActiveRecord methods are currently escaping me.
  # @current_user = User.find_by_id(params[:user_id])
  @plays = Play.all
  @award_categories = Award.all
  @nominations = Nomination.where({"user_id" => current_user.id})
  binding.pry
  render "home"
end







end