class UsersController < ApplicationController

# write methods named for each action here!

  def home
    #@viewings = Viewing.where(params[:secret_number] => self.user.secret_number) #or something...ActiveRecord methods are currently escaping me.
    # WE WON'T NEED LINE 8 BECAUSE ACTIVERECORD ASSOCIATIONS ARE AMAZING, BUT I DON'T WANT TO DELETE IT IN CASE RYAN IS USING THAT VARIABLE ON THE VIEW. CURRENTLY FIXING A MERGE CONFLICT.
    @plays = Play.includes(:theater).for_voting_period(Time.now.strftime("%Y"))
    ### add sign in check here...
  end
  

  #def set_password
   # @user = User.find_by_secret_number(params[:secret_number])
  #end

  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:register, :set_password]

  def register
    ## How is this working!?!? Or, what should we doing now for registration validation??
    #@user = User.find_by_secret_number(params[:secret_number])
    #sign_in(@user)
  end

  def set_password
    if @user = User.find_by_secret_number(params[:secret_number])
      sign_in(@user)
    else
      redirect_to :root, alert: "No user found."
    end
  end

  def update
    @user = current_user
    if params[:password] == params[:password_confirmation]
      @user.password = params[:password]
      @user.save
      sign_in(@user, :bypass => true)
      redirect_to "/users/home", :notice => "Your Password has been updated!"
    else 
      render :set_password, :notice => "Invalid Password Entry"
    end
  end

  def settings_page
  end

  def settings_changed
    @user = current_user
    @user.full_name = params[:full_name]
    @user.email = params[:email]
    @user.username = params[:username]
    @user.save
    redirect_to "/users/home", :notice => "Your settings have been changed!"
  end

  def nomination_email
    users = User.where('email IS NOT NULL')
    users.each do |user|
      NominationMailer.nomination_email(user).deliver_now
    end
    redirect_to "/admin", :notice => "Nomination emails have now been sent!"
  end

  def ballot_email
    users = User.where('email IS NOT NULL')
    users.each do |user|
      BallotMailer.ballot_email(user).deliver_now
    end
    redirect_to "/admin", :notice => "Ballot emails have now been sent!"
  end

end