class NominationsController < ApplicationController
  def nomination_ballot
    @awards = Award.all
    @actor_leading_role = PotentialNomination.where(award_id: 2)
  end
end