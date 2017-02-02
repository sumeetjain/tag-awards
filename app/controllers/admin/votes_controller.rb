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

    def index
      # What I want:
      # resources = resources.for_voting_period(session[:year])
      # In `super`, `render locals:...` has resources, which I'd love for the
      # above assignment to overwrite. But local vars dont carry into `super`,
      # so it doesn't work. Instead, I'm just copy/pasting all of super here.

      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run
      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      resources = resources.for_voting_period(session[:year])

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    def close
      VotingPeriod.current.update(ballot_status: "closed")
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