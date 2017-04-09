class NominationsController < ApplicationController
  def nomination_ballot
    @awards = Award.all
    @ballot_status = VotingPeriod.current.ballot_status
    @prev_noms = user_current_nominations
  end

  def update
    @user = current_user
    if @user.nominations == []
      @user.nominations.create(params[:nominations].map { |v| {potential_nomination_id: v } })
    else
      prev_noms = Nomination.where(user_id: @user)
      new_noms = params[:nominations]
      nom_counter = 0
      prev_noms.each do |nom|
        nom.update(potential_nomination_id: new_noms[nom_counter])
        nom_counter += 1
      end
    end 
    redirect_to :root, notice: "Nominations saved!"
  end

  ##
  def user_current_nominations
    user_prev_noms = Nomination.where(user_id: current_user.id).map { |nom| nom.potential_nomination_id }
    binding.pry
    if user_prev_noms == []
      return new_user_noms
    else
      return user_prev_noms
    end
  end

  ##
  def new_user_noms
    new_user_array = []
    140.times do
      new_user_array << ""
    end
    return new_user_array
  end
end