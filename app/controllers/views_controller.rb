class ViewingsController < ApplicationController

  def list
    @viewings = Viewing.where({"user_id" => params[:id]})
  end

end