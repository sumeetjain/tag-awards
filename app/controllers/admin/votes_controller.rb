module Admin
  class VotesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Viewing.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Viewing.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def close
      VotingPeriod.current.update(ballot_status: "final_voting_closed")
      redirect_to :admin_votes, notice: "Final voting closed! Go ahead and export now."
    end

    def export
      @votes = Vote.bulk_export

      respond_to do |format|
        format.html
        format.csv { send_data @votes }
      end
    end

    def export_viewings
      @viewings = Vote.export_viewings

      respond_to do |format|
        format.html
        format.csv { send_data @viewings }
      end
    end
  end
end