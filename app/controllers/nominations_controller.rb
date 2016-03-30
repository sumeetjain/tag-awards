class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
    @users_prev_noms = Nomination.where("user_id" => current_user.id)
  end

  def save_nominee
    current_user.record_nominations(current_user.id, params[:awards])
    redirect_to "/users/home"
  end

# Ultimately put this in the admin controller
# 
  def index
    @nominations = Nomination.all
    @weight = @nominations[1].weight
    #@sorted_nominations = @nominations.sort_by {|nom| nom.weight}
    @sorted_nominations = Nomination.rank_by_voter_weight
  end 


end