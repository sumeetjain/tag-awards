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
  #a class method to CLOSE nominations
  #(triggered via the admin/users page)
  #"open" boolean in nom table switched to false
  def self.close_nominations
    all_noms = self.all
    all_noms.each do |nom|
      nom.open = false
      nom.save
    end
  end
  #for testing purposes, to undo close_nominations
  #(not triggered anywhere at this time)
  #"open" boolean in nom table switched to true
  def self.open_nominations
    all_noms = self.all
    all_noms.each do |nom|
      nom.open = true
      nom.save
    end
  end

  def self.nominations_closed
    closed_noms = Nomination.where(open: false)
    if closed_noms.length > 0
      return true
    end
  end
end
