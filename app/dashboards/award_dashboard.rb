require "administrate/base_dashboard"

class AwardDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    award_name: Field::String.with_options(truncate: 1000),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    inactive: Field::Boolean,
    nominations: Field::HasMany,
    award_type: Field::String
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :award_name,
    :award_type
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :award_name,
    :award_type
    # :nominations # Add this to see nominations for each award.
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :award_name,
    :award_type,
    :inactive
  ]

  # Overwrite this method to customize how awards are displayed
  # across all pages of the admin dashboard.
  
  def display_resource(award)
    "#{award.short_name}"
  end
end
