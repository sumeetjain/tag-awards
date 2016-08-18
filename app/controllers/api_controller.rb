class ApiController < ApplicationController
  
  


  def index
  	@plays = Play.includes(:theater).all
  	
  end




end
