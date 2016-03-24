class NominationsController < ActionController::Base

  def nomination_ballot
    @nominations = Nomination.all
  end


end