require "administrate/base_dashboard"

class BallotItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    award: Field::BelongsTo,
    id: Field::Number,
    potential_nomination: Field::BelongsTo,
    score: Field::Number,
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
    :award,
    :potential_nomination,
    :score,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :award,
    :potential_nomination,
    :id,
    :score,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :award,
    :potential_nomination,
    :score,
    :voting_period,
  ]

  # Overwrite this method to customize how ballot items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(ballot_item)
    ballot_item.potential_nomination.display_name
  end
end
