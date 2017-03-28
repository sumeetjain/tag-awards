require "administrate/base_dashboard"

class PlayForCurrentYearDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artists: Field::HasMany,
    theater: Field::BelongsTo,
    voting_period: Field::BelongsTo,
    viewings: Field::HasMany,
    ballot_items: Field::HasMany,
    potential_nominations: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :artists,
    :theater,
    :voting_period,
    :viewings,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :artists,
    :theater,
    :voting_period,
    :viewings,
    :ballot_items,
    :potential_nominations,
    :id,
    :title,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :artists,
    :theater,
    :voting_period,
    :viewings,
    :ballot_items,
    :potential_nominations,
    :title,
  ]

  # Overwrite this method to customize how play for current years are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(play_for_current_year)
    "#{play_for_current_year.title}"
  end
end
