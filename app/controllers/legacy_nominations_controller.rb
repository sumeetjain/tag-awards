class NominationsController < ApplicationController

  def nomination_ballot
    @awards = Award.all
    @users_prev_noms = Nomination.where("user_id" => current_user.id)
    if Nomination.nominations_closed == true
      session[:nominations_closed] = true
    else
      session[:nominations_closed] = false
    end
  end
  
  def close_nominations
    Nomination.close_nominations
    redirect_to "/admin/nominations", :notice => "Nominations are now closed! Online nomination ballots are no longer visible to your members"
    Nomination.create_ballot_item  
  end

  def save_nominee
    current_user.record_nominations(current_user.id, params[:awards]) 
    redirect_to "/users/home"
  end
 
  def index
    @ranked_noms = Nomination.ranked_by_weight
    @nominations = Nomination.all
    #@sorted_nominations = Nomination.rank_by_voter_weight
    @awards = Award.all
  end 
end