class NominationsController < ApplicationController

  def nomination_ballot
    if Nomination.nominations_closed != true
      @awards = Award.all
      @users_prev_noms = Nomination.where("user_id" => current_user.id)
    else
      redirect_to "users/home"
      flash[:notice] = "Nominations have been closed for the 2016 TAG Awards."
    end
  end

  def close_nominations
    Nomination.close_nominations
    redirect_to "/admin/nominations", :notice => "Nominations are now closed! Online nomination ballots are no longer visible to your members"
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