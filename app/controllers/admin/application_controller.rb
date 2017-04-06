# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    
    before_filter :authenticate_admin
    before_action :get_period

    def authenticate_admin
      if !current_user || !current_user.admin?
        redirect_to :root, alert: "Not authorized"
      end
      # TODO Add authentication logic here.
    end

    # Filter the content on the dashboard for one voting period at a time
    def get_period
      year = session[:year]
      @period = VotingPeriod.where(year: year)[0]

      # If there wasn't data in the session or it was an invalid year, default
      # to the current year.
      unless @period
        @period = VotingPeriod.current
      end
      session[:year] = @period.year
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

  end
end
