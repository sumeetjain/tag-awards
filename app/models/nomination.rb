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
  # This method creates ballot items based on nominations ranked by weight, so table will automatically populate with ballot items.

  def self.create_ballot_item
    nomination = self.ranked_by_weight


    nomination.each do |nom,weight|
      @ballot_item = BallotItem.new
      @ballot_item.nominee  = nom.nominee
      @ballot_item.role     = nom.role
      @ballot_item.award_id = nom.award_id
      @ballot_item.weight = weight
      @ballot_item.approved = false
      @ballot_item.play_id  = Play.find_by_title(nom.show).id
      @ballot_item.save
    end
  end  

  # Defines an 'approved nomination' as one having its approved attribute set to 'true' by the Admin
  def self.approved_by_admin
    self.where({"approved" => true})
  end

  # Identifies nominations sharing identical attributes (nominee, role, award_id, theater, show)
  def self.duplicates
    self.approved_by_admin.select(:nominee,:role,:award_id,:theater,:show).group(:nominee,:role,:award_id,:theater,:show).select("count(*) AS count").having("count(*) > 1")
  end

  # Returns a hash with keys of single iterations of duplicate nominations (as found by the above method 'duplicate_noms') and values of that nomination's weight as defined by users' weights (who made the nominations) and how many times that nomination occurs
  def self.ranked_by_weight
    ranks = {}

    self.duplicates.each do |nom|
      # array of all of the weights of all users who submitted nominations for this nominee
      user_weights = Nomination.where(nominee: nom.nominee, role: nom.role, award_id: nom.award_id, theater: nom.theater, show: nom.show).joins(:user).pluck("users.weight")

      # sum the array. that's the total weight for all of these nominations.
      ranks[nom] = user_weights.sum
    end
    ranks.sort_by{|k,v| v}.reverse.to_h
  end
end
