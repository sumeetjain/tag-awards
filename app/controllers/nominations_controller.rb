class NominationsController < ApplicationController
  def nomination_ballot
    @awards = Award.all
    @nominations = build_potential_nominations
    @ballot_status = VotingPeriod.current.ballot_status
    @prev_noms = is_already_nominated
  end

  # Builds a Hash of all potential nominations for output on the nominations ballot.
  def build_potential_nominations
    potential_nominations = {}
    @awards.each do |award|
      nom_category = PotentialNomination.where(award_id: award.id)
      formatted_noms = nomination_ballot_format(nom_category)
      potential_nominations[award.id] = {}
      counter = 0
      nom_category.each do |nom|
        potential_nominations[award.id][nom.id] = formatted_noms[counter]
        counter += 1
      end
    end
    return potential_nominations
  end

  # Formats each potential nomination in the above Hash as it's display_name.
  def nomination_ballot_format(potential_nominations)
    formatted_noms = []
    potential_nominations.each do |potential_nomination|
      formatted_noms << potential_nomination.display_name
    end
    return formatted_noms
  end

  # Builds a Hash containing a user's potential_nomination_id's to build the select form with their previous selections already selected (should they choose to go back and change their nominations). If it is a user's first time a has containing blanks is returned to tell the select form to select nothing.
  def is_already_nominated
    users_prev_noms = Nomination.where(user_id: current_user.id)
    if users_prev_noms == []
      return new_user_noms
    else
      prev_noms_array = []
      users_prev_noms.each do |nom|
        prev_noms_array << nom.potential_nomination_id
      end
      prev_noms_array = prev_noms_array.each_slice(5).to_a
      return prev_noms_array
    end
  end

  # Builds the 'new user' Hash described above.
  def new_user_noms
    empty_noms_array = []
    28.times do
      empty_awards_array = []
      5.times do
        empty_awards_array << 0
      end
      empty_noms_array << empty_awards_array
    end
    return empty_noms_array
  end

  # Saves a user's nominations.
  def save_nominees
    current_user.record_nominations(current_user.id, params[:noms]) 
    redirect_to "/nomination_ballot"
  end
end