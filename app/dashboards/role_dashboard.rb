require "administrate/base_dashboard"

class RoleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artist: Field::BelongsTo,
    play: Field::PlayForYearField,
    voting_period: Field::BelongsTo,
    potential_nomination: Field::BelongsTo,
    id: Field::Number,
    job: Field::String,
    character: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :artist,
    :play,
    :voting_period,
    :potential_nomination,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :artist,
    :play,
    :voting_period,
    :potential_nomination,
    :id,
    :job,
    :character,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :artist,
    :play,
    :voting_period,
    :potential_nomination,
    :job,
    :character,
  ]

  # Overwrite this method to customize how roles are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(role)
    "#{role.artist.name} as #{role.job} in #{role.play.title}"
  end
end
