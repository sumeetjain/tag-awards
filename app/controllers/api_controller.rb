class ApiController < ApplicationController
  def index
    @api_response = Api.new

    render :json => {:theaters => @api_response.all}

  	# @plays = Theater.all
  	# render :json => 
  	# 	@plays.to_json(:only => [:name], 
  	# 					:include => {
  	# 					  :plays => {:only => [:title]}
  	# 					  }
  	# 				)

  end
end
