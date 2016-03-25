class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
  end

  def save_nominee
    @new_nom = Nomination.new
    @new_nom.award_id = @award_id
    @new_nom.nominee = params[:theater(@award_id)_1]
    @new_nom.user_id = current_user.id
    @new_nom.role = params[:role]
    binding.pry
    @new_nom.save
    redirect_to "users/home"
  end



end