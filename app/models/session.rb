class Session
  attr_accessor :user

  def initialize session
    @session = session
    @user = User.find_by(username: session[:username])
    @password = session[:password]
  end

  def valid?
    @user && @user.authenticate(@session[:password]) && @user.membership_active
  end

  def error_summary
    if !@user or !user.authenticate(@session[:password])
      return 'Invalid username/password combination'
    else
      return 'TAG membership not active.'
    end
  end
end
