class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
  end

  def save_nominee
    @new_nom = Nomination.new
    @new_nom.nominee = params[:theater]
    @new_nom.award_id = @award_id
    @new_nom.user_id = current_user.id
    @new_nom.role = params[:role]
    @new_nom.save
    render "users/admin"
  end



end