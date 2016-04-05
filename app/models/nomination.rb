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

  def ranked_nominations
    
  end
end
