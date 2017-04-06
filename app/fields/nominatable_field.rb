require "administrate/field/base"

class NominatableField < Administrate::Field::BelongsTo
  def to_s
    data
  end

end
