class Nominatable < ApplicationRecord
  # Nominees: [Play, Role]
  belongs_to :nominee, polymorphic: true
  belongs_to :award
  validates :display_name, presence: true, length: { maximum: 100 }
  before_validation :set_display_name

  def set_display_name
    self.display_name = nominee.display_name
  end
end
