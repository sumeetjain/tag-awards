class ApiController < ApplicationController
 

def index
  	@plays = Theater.all
  	render :json => @plays
  end

end



