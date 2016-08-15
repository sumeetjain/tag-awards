class Award < ActiveRecord::Base
  has_many :nominations
  has_many :ballot_items
  #label converts award_name to Courtney's CSS label system
  #example: "Best Musical" will become "bestmusical"
  def label
    self.award_name.split.join.downcase
  end

  def short_name
    regex = /(Outstanding )(Achievement|Performance)?( by an )?( in )?( by a )?/

    award_name.gsub(regex, "")
  end

  def needs_nominee_input?
    type = award_type
    if type == "directing" || type == "technical" || type == "acting"
      return true
    else
      return false
    end
  end

  def needs_role_input?
    type = award_type
    if type == "acting"
      return true
    else
      return false
    end
  end

end
