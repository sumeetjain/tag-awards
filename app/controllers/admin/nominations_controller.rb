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

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run
      # resources = resources.for_voting_period(session[:year])
      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    #Ballot Builder
  	def top_ten
      @theaters = Theater.includes(:plays).all
      @awards = Award.includes(:ballot_items => {play: :theater}).order("awards.award_name asc").all
    end

    def build_ballot
      Nomination.saveBallotItems(params)
      redirect_to :top_ten_admin_nominations, notice: "Ballot for #{@award.award_name} set!"
    end
    
  end
end
