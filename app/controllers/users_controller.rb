class UsersController < ApplicationController

# write methods named for each action here!

  def home
    #@viewings = Viewing.where(params[:voter_token] => self.user.voter_token) #or something...ActiveRecord methods are currently escaping me.
    # WE WON'T NEED LINE 8 BECAUSE ACTIVERECORD ASSOCIATIONS ARE AMAZING, BUT I DON'T WANT TO DELETE IT IN CASE RYAN IS USING THAT VARIABLE ON THE VIEW. CURRENTLY FIXING A MERGE CONFLICT.
    @plays = Play.all
    @award_categories = Award.all
  end

  

  #def set_password
   # @user = User.find_by_voter_token(params[:voter_token])
  #end

  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:register, :set_password]

  def register
    @user = User.find_by_voter_token(params[:voter_token])
    sign_in(@user)
  end

  def set_password
    @user = current_user
  end

  def update
    binding.pry
    @user = current_user
    # raise params.inspect
    if @user.update(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, :notice => "Your Password has been updated!"
    else
      render :set_password,:locals => { :resource => @user, :resource_name => "user" }
    end
  end


end