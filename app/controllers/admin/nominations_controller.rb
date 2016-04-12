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


# TODO (Amy) delete the index method below and instead consolidate into one ballot helper action that goes to a page of nominations sorted by nominee and voter_weight.

    def index
      search_term = params[:search].to_s.strip
      #resources = Administrate::Search.new(resource_resolver, search_term).run
      if params[:order]
        resources = order.apply(resources)
      else
        resources = Nomination.order(nominee: :desc)
      end
      #order = Administrate::Order.new()
      #resources = order.apply(resources)
      resources = resources.page(params[:page]).per(50)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    # def ballot_helper
    #     @resources = Nomination.order(:nominee)
    #     @resources.page(params[:page]).per(10)
    #     page = Administrate::Page::Collection.new(dashboard, )
    # end


  end

end
