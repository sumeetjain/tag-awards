class ApiController < ApplicationController
 
def index
  	@noms = Nomination.all
  	@prods = Play.all
  	@venue = Theater.all
  end

end



