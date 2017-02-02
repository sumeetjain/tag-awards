require "administrate/base_dashboard"

class PlayDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    theater: Field::BelongsTo,
    potential_nominees: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    voting_period: Field::BelongsTo,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :theater,
    :title,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :theater,
    :title,
    :created_at
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :theater,
    :title,
    :potential_nominees,
    :voting_period
  ]

  # Overwrite this method to customize how plays are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(play)
    "#{play.title} (at #{play.theater.name})"
  end
end
