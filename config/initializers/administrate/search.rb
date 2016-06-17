module Administrate
  class Search
    def run
      if @term.blank?
        resource_class.all
      else
        Nomination.full_search(term)
      end
    end
  end
end
