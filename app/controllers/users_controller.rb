class UsersController < ApplicationController

# write methods named for each action here!

  def home
    @plays = Play.includes(:theater).for_voting_period(Time.now.strftime("%Y"))
  end

  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:register, :set_password]

  def settings_changed
    if params[:password] == params[:confirm_password]
      @user = current_user
      @user.password = params[:password]
      @user.full_name = params[:full_name]
      @user.email = params[:email]
      @user.username = params[:username]
      @user.save
      sign_in(@user, :bypass => true)
      redirect_to "/users/home", :notice => "Your settings have been changed!"
    else
      redirect_to "/users/home", :notice => "Invalid Password Entry"
    end
  end

  ## Jamie: Is this being used??
  # def nomination_email
  #   users = User.where('email IS NOT NULL')
  #   users.each do |user|
  #     NominationMailer.nomination_email(user).deliver_now
  #   end
  #   redirect_to "/admin", :notice => "Nomination emails have now been sent!"
  # end

  # def ballot_email
  #   users = User.where('email IS NOT NULL')
  #   users.each do |user|
  #     BallotMailer.ballot_email(user).deliver_now
  #   end
  #   redirect_to "/admin", :notice => "Ballot emails have now been sent!"
  # end
end