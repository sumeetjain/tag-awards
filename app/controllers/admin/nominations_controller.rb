module Admin
  class NominationsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Nomination.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Nomination.find_by!(slug: param)
    # end


    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def toggle_approval
      @nomination = Nomination.find(params[:id])

      @nomination.toggle_approval!

      respond_to do |format|
        format.js
      end
    end

    # def ballot_helper
    #     @resources = Nomination.order(:nominee)
    #     @resources.page(params[:page]).per(10)
    #     page = Administrate::Page::Collection.new(dashboard, )
    # end


  end

end
