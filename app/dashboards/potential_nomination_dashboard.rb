require "administrate/base_dashboard"



class PotentialNominationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    nominatable: Field::NominatableField,
    award: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    display_name: Field::String.with_options(truncate: 1000),
    nominatable_type: Field::String,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :display_name,
    :award
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :award,
    :nominatable,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :award,
    :nominatable,
  ]

  # Overwrite this method to customize how potential nominations are displayed
  # across all pages of the admin dashboard.
  
  def display_resource(potential_nomination)
    "#{potential_nomination.display_name}"
  end

  def permitted_attributes
    super << attribute_types[:nominatable_type].permitted_attribute(:nominatable_type)
  end

end

