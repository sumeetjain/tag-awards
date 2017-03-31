class PotentialNomination < ActiveRecord::Base
  has_many :roles
  belongs_to :award
  has_many :nominations

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  def display_name
    formatted_name = ""
    if needs_artist_name? then formatted_name += build_names end
    needs_character_name? ? formatted_name += character_name : formatted_name += " -"
    formatted_name += play_info
    formatted_name += award_name
  end

  def needs_artist_name?
    award.needs_nominee_input?
  end 

  def needs_character_name?
    award.needs_role_input?
  end

  def build_names
    names = []
    roles.each do |role|
      names.push(role.artist.name)
    end
    names.join(", ")
  end

  def character_name
    " as #{roles.first.character} in"
  end

  def play_info
    " #{roles.first.play.title}, #{roles.first.play.theater.name}"
  end

  def award_name
    " for #{award.short_name}"
  end
end
