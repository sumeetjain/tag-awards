class Theater < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  has_many :plays, dependent: :destroy

  # Returns a list of the theater's plays for the current voting period
  def current_voting_period_plays
    plays.joins(:voting_period).where('active = true')
  end
end
