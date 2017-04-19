class ApiController < ApplicationController
 

def index
  	@plays = Theater.all
  	render :json => 
  		@plays.to_json(:only => [:name], 
  						:include => {
  						  :plays => {:only => [:title]}
  						  }
  					)	

  end

end
