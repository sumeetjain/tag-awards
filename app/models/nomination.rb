class Nomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :award


  def weight
     weight = self.user.viewings.count
     if weight <= 10
      return 1
    elsif weight >= 11 && weight <= 20
      return 2
    elsif weight >= 21 && weight <= 30
      return 3
    elsif weight >= 31 && weight <= 40
      return 4
    elsif weight >= 41
      return 5
    end
  end

  def self.rank_by_voter_weight
    all_noms = self.all
    sorted_noms = all_noms.sort_by {|nom| nom.weight}
    return sorted_noms
  end

  # Defines an 'approved nomination' as one having its approved attribute set to 'true' by the Admin
  def self.approved_nominations
    self.where({"approved" => true})
  end

  # Identifies nominations sharing identical attributes (nominee, role, award_id, theater, show)
  def self.duplicate_nominations
    self.approved_nominations.select(:nominee,:role,:award_id,:theater,:show).group(:nominee,:role,:award_id,:theater,:show).select("count(*) AS count").having("count(*) > 1")
  end

  # Returns a hash with keys of single iterations of duplicate nominations (as found by the above method 'duplicate_noms') and values of that nomination's weight as defined by users' weights (who made the nominations) and how many times that nomination occurs
  def self.ranked_nominations
    ranks = {}

    self.duplicate_nominations.each do |nom|
      # array of all of the weights of all users who submitted nominations for this nominee
      user_weights = Nomination.where(nominee: nom.nominee, role: nom.role, award_id: nom.award_id, theater: nom.theater, show: nom.show).joins(:user).pluck("users.weight")

      # sum the array. that's the total weight for all of these nominations.
      ranks[nom] = user_weights.sum * nom.count
    end
    ranks
  end

end
