class Nominatable < ApplicationRecord
  # Nominees: [Play, Role]
  belongs_to :nominee, polymorphic: true
  belongs_to :award
  has_many   :nominations, dependent: :destroy
  validates :display_name, presence: true
  validates :nominee_id, uniqueness: { scope: :award_id }
  before_validation :set_display_name

  def set_display_name
    self.display_name = nominee.display_name if nominee
  end
end
