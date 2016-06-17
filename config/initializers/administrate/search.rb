module Administrate
  class Search
    def run
      if @term.blank?
        resource_class.all
      else
        if resource_class.respond_to?(:full_search)
          resource_class.full_search(term)
        else
          resource_class.where(query, *search_terms)
        end
      end
    end
  end
end
