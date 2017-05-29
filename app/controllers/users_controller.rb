class UsersController < ApplicationController
  # Sets @plays to all plays for current year.
  #
  # Returns an Array of ActiveRecord objects.
  def home
    @theaters = Theater.order("name ASC")
  end

  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:register, :set_password]

  # Updates user information.
  def settings_changed
    @user = current_user
    @user.full_name = params[:full_name]
    @user.username = params[:username]
    @user.email = params[:email]
    @user.save
    redirect_to "/users/home", :notice => "Your settings have been changed!"
  end

  # Updates user's password.
  def change_password
    if params[:password] == params[:confirm_password]
      @user = current_user
      @user.password = params[:password]
      @user.save
      sign_in(@user, :bypass => true)
      redirect_to "/users/home", :notice => "Your password has been changed!"
    else
      redirect_to "/users/home", :notice => "Invalid password Entry"
    end
  end
end