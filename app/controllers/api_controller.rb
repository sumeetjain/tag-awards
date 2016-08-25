class ApiController < ApplicationController
  def index
    @api_response = Api.new

    render :json => {:theaters => @api_response.all}
  end
end
