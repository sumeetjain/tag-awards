module Admin
  class VotingPeriodsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = VotingPeriod.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   VotingPeriod.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def set_period
      # Sets the year for the current voting period in the session.
      session[:year] = params[:year]
      redirect_to request.referrer
    end
  end
end