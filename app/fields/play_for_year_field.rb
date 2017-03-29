require "administrate/field/base"

class PlayForYearField < Administrate::Field::BelongsTo
  def selected_title
    data.title
  end
end
