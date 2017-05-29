class PotentialNomination < ActiveRecord::Base
  NOMINATABLES = [Play,Role]
  belongs_to :nominatable, polymorphic: true

  belongs_to :award
  has_many :nominations

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  before_save :set_display_name

  def set_display_name
    self.display_name = nominatable.display_name
  end

  # def display_name
  #   roles.length > 1 ? display_multi_role : roles.first.display_name
  # end

  # def display_multi_role
  #   formatted_name = ""
  #   formatted_name += build_names if needs_artist_name?
  #   formatted_name += play_info
  # end

  # def display_name_with_award
  #   display_name += award_name
  # end

  # def needs_artist_name?
  #   award.needs_nominee_input?
  # end 

  # def needs_character_name?
  #   award.needs_role_input?
  # end

  # def build_names
  #   names = []
  #   roles.each do |role|
  #     names.push(role.artist.name) 
  #   end
  #   formatted = names.join(", ")
  #   formatted += " - " + roles.first.job.pluralize
  # end

  # # def character_name
  # #   " as #{roles.first.character} in"
  # # end

  # def play_info
  #   " - #{roles.first.play.title}, #{roles.first.play.theater.name}"
  # end

  # def award_name
  #   " for #{award.short_name}"
  # end
end
