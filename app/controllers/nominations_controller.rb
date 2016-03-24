class NominationsController < ActionController::Base

  def nomination_ballot
    @nominations = Nomination.all
    @awards = Award.all
  end


end