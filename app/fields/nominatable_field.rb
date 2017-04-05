require "administrate/field/base"

class NominatableField < Administrate::Field::BelongsTo
  def to_s
    data
  end

  # def display_associated_resource
  #   PotentialNominationsDashboard
  # end
end
