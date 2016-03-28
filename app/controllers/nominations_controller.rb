class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
    @users_prev_noms = Nomination.where("user_id" => user_id)
  end

  def save_nominee
    current_user.record_nominations(current_user.id, params[:awards])
    redirect_to "/users/home"
  end

end