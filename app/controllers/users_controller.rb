class UsersController < ApplicationController

# write methods named for each action here!

  def home
    #@viewings = Viewing.where(params[:voter_token] => self.user.voter_token) #or something...ActiveRecord methods are currently escaping me.
    @viewings = Viewing.where({"user_id" => current_user.id})
    @current_user = User.find_by_voter_token(params[:voter_token])
    @plays = Play.all
    @award_categories = Award.all
    render "home"
  end


end