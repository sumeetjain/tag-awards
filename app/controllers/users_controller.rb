class UsersController < ApplicationController

# write methods named for each action here!

  def home
    #@viewings = Viewing.where(params[:voter_token] => self.user.voter_token) #or something...ActiveRecord methods are currently escaping me.
    # WE WON'T NEED LINE 8 BECAUSE ACTIVERECORD ASSOCIATIONS ARE AMAZING, BUT I DON'T WANT TO DELETE IT IN CASE RYAN IS USING THAT VARIABLE ON THE VIEW. CURRENTLY FIXING A MERGE CONFLICT.
    # @viewings = Viewing.where({"user_id" => current_user.id})
    @plays = Play.all
    @award_categories = Award.all
    render "home"
  end


end