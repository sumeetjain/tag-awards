class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
  end

  def save_nominee
    @current_user_id = current_user.id
    current_user.record_nominations(params[:awards])
    redirect_to "/users/home"
  end



end