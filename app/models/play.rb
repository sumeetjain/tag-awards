class Play < ApplicationRecord
  belongs_to :voting_period
  belongs_to :theater
  validates :title, presence: true, length: { maximum: 255 }
  validates :title, uniqueness: { scope: [:theater_id, :voting_period_id] }
  has_many :viewings, dependent: :destroy

  # Returns a list of plays for the current voting period
  def self.for_current_voting_period
    self.where(voting_period: VotingPeriod.where(active: true))
  end
end
