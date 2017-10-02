class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :not_logged_in?

  private

    def not_logged_in?
      redirect_to login_path if !logged_in?
    end

    def correct_user?
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_url
      end
    end
end
