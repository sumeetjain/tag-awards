class NominationsController < ApplicationController

  def nomination_ballot
    if Nomination.nominations_closed == true
      redirect_to "users/home", :notice => "Nominations have been closed for the 2016 TAG Awards."
    else
      @awards = Award.all
      @users_prev_noms = Nomination.where("user_id" => current_user.id)
    end
  end

  def save_nominee
    current_user.record_nominations(current_user.id, params[:awards])
    redirect_to "/users/home"
  end
 
  def index
    @nominations = Nomination.all
    #@sorted_nominations = Nomination.rank_by_voter_weight
    @awards = Award.all
  end 
end