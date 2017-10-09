class Viewing < ApplicationRecord
  belongs_to :user
  belongs_to :play
  validates :user_id, uniqueness: { scope: :play_id }
  scope :for_current_voting_period, -> { joins(play: :voting_period).where('active = true') }
end
