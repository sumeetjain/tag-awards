class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :not_logged_in?

  private

    def not_logged_in?
      redirect_to login_path if !logged_in?
    end

    def redirect_if_logged_in
      redirect_to user_plays_path(current_user) if logged_in?
    end

    def correct_user?
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:danger] = "You don't have access to that page."
        redirect_to root_url
      end
    end
end
