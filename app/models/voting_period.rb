class VotingPeriod < ActiveRecord::Base
  validates :year, presence: true, uniqueness: true
  validates :ballot_status, inclusion: {in: %w(pending nominations voting closed), message: "%{value} is not a valid status of 'pending', 'nominations', 'voting', or 'closed'."}
  # Valid ballot statuses:
  # pending - This period has been set up but is not yet open for nominations.
  # nominations - This period is currently accepting nominations.
  # voting - This period is currently accepting final votes.
  # closed - This period is not currently accepting nominations or final votes.

  has_many :ballot_items
  has_many :nominations
  has_many :plays
  
  def self.current
    order("year DESC").first
  end
end