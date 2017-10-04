class Viewing < ApplicationRecord
  belongs_to :user
  belongs_to :play
  validates :user_id, uniqueness: { scope: :play_id }
end
