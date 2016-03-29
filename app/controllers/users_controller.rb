class UsersController < ApplicationController

# write methods named for each action here!

  def home
    #@viewings = Viewing.where(params[:voter_token] => self.user.voter_token) #or something...ActiveRecord methods are currently escaping me.
    # WE WON'T NEED LINE 8 BECAUSE ACTIVERECORD ASSOCIATIONS ARE AMAZING, BUT I DON'T WANT TO DELETE IT IN CASE RYAN IS USING THAT VARIABLE ON THE VIEW. CURRENTLY FIXING A MERGE CONFLICT.
    @plays = Play.all
    @award_categories = Award.all
  end

  def register
    @user = User.find_by_voter_token(params[:voter_token])
  end

  def set_password
    @user = User.find_by_voter_token(params[:voter_token])
  end

  def activate_set_user

  end


end