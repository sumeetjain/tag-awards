class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
  end

  def save_nominee
    @new_nom = Nomination.new
    binding.pry
    @new_nom.award_id = params[:award_id]
    @award_id = params[:award_id]
    @nom_count = params[:nom_count]
    @new_nom.user_id = current_user.id
    #@new_nom.nominee = params[:current_award_data]
    #@new_nom.role = params[:role]
    @new_nom.save

    redirect_to "users/home"
  end



end