module Admin
  class NominationsController < Admin::ApplicationController


    


    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information


    # NO LONGER NEEDED
    # def toggle_approval
    #   @nomination = Nomination.find(params[:id])

    #   @nomination.toggle_approval!

    #   respond_to do |format|
    #     format.js
    #   end
    # end

    # def ballot_helper
    #     @resources = Nomination.order(:nominee)
    #     @resources.page(params[:page]).per(10)
    #     page = Administrate::Page::Collection.new(dashboard, )
    # end

  end
end