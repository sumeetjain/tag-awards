class Award < ActiveRecord::Base
  has_many :nominations
  has_many :ballot_items
  has_many :potential_nominations

  enum award_type: %w(acting directing technical production ensemble)
  
  #label converts award_name to Courtney's CSS label system
  #example: "Best Musical" will become "bestmusical"
  def label
    self.award_name.split.join.downcase
  end

  def options_for_select
    self.potential_nominations
    .order("display_name ASC")
    .select(:display_name, :id)
    .map { |nom| [nom.display_name, nom.id] }
  end

  def short_name
    regex = /(Outstanding )(Achievement|Performance)?( by an )?( in )?( by a )?/

    award_name.gsub(regex, "")
  end

  def needs_nominee_input?
    award_type == "directing" || award_type == "technical" || award_type == "acting"
  end

  def needs_role_input?
    award_type == "acting" 
  end

  def self.ballot_set_false
    self.update_all(ballot_set: false)
  end

end
