class NominationsController < ApplicationController
  def nomination_ballot
    @awards = Award.all
    #@nominations = build_potential_nominations

    if Nomination.nominations_closed == true
      session[:nominations_closed] = true
    else
      session[:nominations_closed] = false
    end

    @user_noms = user_noms
  end

  # def build_potential_nominations
  #   potential_nominations = {}
  #   @awards.each do |award|
  #     nom_category = PotentialNomination.where(award_id: award.id)
  #     formatted_noms = nomination_ballot_format(nom_category)
  #     potential_nominations[award.id] = {}
  #     counter = 0
  #     nom_category.each do |nom|
  #       potential_nominations[award.id][nom.id] = formatted_noms[counter]
  #       counter += 1
  #     end
  #   end
  #   return potential_nominations
  # end

  # def nomination_ballot_format(potential_nominations)
  #   formatted_noms = []
  #   potential_nominations.each do |potential_nomination|
  #     formatted_noms << potential_nomination.display_name
  #   end
  #   return formatted_noms
  # end

  def save_nominees
    current_user.record_nominations(current_user.id, params[:user]) 
    redirect_to "/nomination_ballot"
  end

  def user_noms
    prev_user_noms = Nomination.where(user_id: current_user)
    if prev_user_noms == nil
      return nil
    else
      return prev_user_noms
    end 
  end
end