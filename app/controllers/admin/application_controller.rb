# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_filter :authenticate_admin
    before_filter :set_year

    def authenticate_admin
      if !current_user || !current_user.admin?
        redirect_to :root, alert: "Not authorized"
      end
      # TODO Add authentication logic here.
    end

    def set_year
      year = params[:year] || VotingPeriod.current.year
      @period = VotingPeriod.where(year: year)[0]
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

  end
end
