class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
    
  end


end