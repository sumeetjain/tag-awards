class SessionsController < ApplicationController
  def new
  end

  def create
    session = Session.new(params[:session])

   if session.valid?
     log_in(session.user)
     params[:session][:remember_me] == '1' ? remember(session.user) : forget(session.user)
     redirect_to(plays_path)
   else
     flash.now[:danger] = session.error_summary
     render 'new'
   end
    # user = User.find_by(username: params[:session][:username])
    # if user && user.authenticate(params[:session][:password]) && user.membership_active
    #   log_in(user)
    #   params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    #   redirect_to(plays_path)
    # elsif !user or !user.authenticate(params[:session][:password])
    #   flash.now[:danger] = 'Invalid username/password combination'
    #   render 'new'
    # else
    #   flash.now[:danger] = 'TAG membership not active.'
    #   render 'new'
    # end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end