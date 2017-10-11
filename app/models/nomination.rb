class Nomination < ApplicationRecord
  belongs_to :nominatable
  belongs_to :user
  validates :user_id, uniqueness: { scope: :nominatable_id }
end
