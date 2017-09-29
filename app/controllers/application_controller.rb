class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :not_logged_in?

  private

    def not_logged_in?
      redirect_to root_path if !logged_in?
    end
end
