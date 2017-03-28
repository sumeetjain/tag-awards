module Admin
  class WinnersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Winner.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Winner.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def show_calculate_winners
    end

    def calculate_winners
        winners = Winner.new
        winners.calculate_winners
        redirect_to :admin_winners, notice: "Success!"
    end

  end
end
