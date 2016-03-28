class NominationsController < ActionController::Base

  def nomination_ballot
    @awards = Award.all
  end

  def save_nominee

    params[:award_id][:nom_count].each do |p|
    # 4 =>
    #   nominations =>
    #     [
    #       {theater: "", show: ""},
    #       {theater: "", show: ""},
    #       {theater: "", show: ""},
    #       {theater: "", show: ""},
    #       {theater: "", show: ""}

    # @new_nom = Nomination.new
    # @new_nom.user_id = current_user.id
    # @new_nom.award_id = params[:]
    # @award_id = params[:]
    # @nom_count = params[:]
    # @new_nom.nominee = params[:]
    # @new_nom.role = params[:]
    # @new_nom.save

    redirect_to "users/home"
  end



end