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
    if award.award_type == "directing" || award.award_type == "technical" || award.award_type == "acting"
    end
  end
end
