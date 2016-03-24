class PlaysController < ApplicationController

  def list
    @plays = Play.where({"user_id" => })
  end

end