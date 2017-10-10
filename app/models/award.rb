class Award < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :award_type, presence: true

  enum award_type: {acting: 1, directing: 2, technical: 3, production: 4,
                    ensemble: 5 }
end
