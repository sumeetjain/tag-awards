class Theater < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
