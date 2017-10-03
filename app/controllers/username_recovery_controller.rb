class UsernameRecoveryController < ApplicationController
  skip_before_action :not_logged_in?
  before_action :redirect_if_logged_in

  def new
  end

  def create
    if User.where(email: params[:email]).any?
      flash[:success] = "Please check your email."
      UserMailer.username_recovery(params[:email]).deliver_now
    else
      flash[:danger] = "No usernames found for that email address."
    end
    redirect_to new_username_recovery_path
  end


end
