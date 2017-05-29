class NominationsController < ApplicationController
  def nomination_ballot
    @awards = Award.all
    @ballot_status = VotingPeriod.current.ballot_status
    @current_noms = user_current_nominations
  end

  def update
    @user = current_user
    prev_noms = Nomination.where(user_id: @user)
    new_noms = params[:nominations]
    nom_counter = 0
    prev_noms.each do |nom|
      nom.update(potential_nomination_id: new_noms[nom_counter])
      nom_counter += 1
    end 
    redirect_to :nomination_ballot, notice: "Nominations saved!"
  end

  ##
  def user_current_nominations
    user_prev_noms = []
    noms_by_award = Nomination.includes(:potential_nomination).where(user_id: current_user.id)
    if noms_by_award == []
      return new_user_noms
    else
      @awards.each do |award|
        award_array = []
        noms_by_award.each do |nom|
          if nom.potential_nomination != nil
            if nom.potential_nomination.award_id == award.id
              award_array << nom.potential_nomination_id
            end
          end
        end
        while award_array.length < 5
          award_array << nil
        end
        user_prev_noms << award_array
      end
    end
    return user_prev_noms
  end

  ##
  def new_user_noms
    140.times do
      Nomination.create({ :potential_nomination_id => nil, :user_id => current_user.id })
    end
    new_user_array = []
    28.times do
      award_array = []
      5.times do
        award_array << nil
      end
      new_user_array << award_array
    end
    return new_user_array
  end
end