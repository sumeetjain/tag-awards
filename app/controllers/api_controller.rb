class ApiController < ApplicationController
  
  def show
    play = Play.find(params[:id])

    render(json: Api::UserSerializer.new(play).to_json)
  end
  


  def index
  end
end
