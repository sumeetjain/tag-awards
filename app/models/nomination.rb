class Nomination < ActiveRecord::Base
  belongs_to :potential_nomination
  accepts_nested_attributes_for :potential_nomination
  belongs_to :user

  validates :potential_nomination, uniqueness: { scope: :user, message: "You may only nominate something once!"}

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  def self.nominations_closed
    # Nomination.where(open: false).count > 0
    false
  end
end
