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

  def self.approved_nominations
    self.where({"approved" => true})
  end

  def self.ranked_nominations
    approved_noms = self.where({"approved" => true})
    identical_noms = {}
    final_noms = []

    approved_noms.each do |nom|
      identical_noms[nom.id] = approved_noms.where("nominee == ? AND role == ? AND award_id == ? AND theater == ? AND show == ?", nom.nominee, nom.role, nom.award_id, nom.theater, nom.show)
    end
    identical_noms
  end

  def self.duplicate_noms
    self.approved_nominations.select(:nominee,:role,:award_id,:theater,:show).group(:nominee,:role,:award_id,:theater,:show).select("count(*) AS count").having("count(*) > 1")
  end

end
