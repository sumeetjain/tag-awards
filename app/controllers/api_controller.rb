class ApiController < ApplicationController
  def index
    render :json => {:theaters => Theater.api_all}

  	# @plays = Theater.all
  	# render :json => 
  	# 	@plays.to_json(:only => [:name], 
  	# 					:include => {
  	# 					  :plays => {:only => [:title]}
  	# 					  }
  	# 				)

  end
end
