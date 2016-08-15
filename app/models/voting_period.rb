class VotingPeriod < ActiveRecord::Base
  validates :year, presence: true, uniqueness: true
  validates :ballot_status, inclusion: {in: %w(pending nominations voting closed)}
  def self.current
    order("year DESC").first
  end
end
