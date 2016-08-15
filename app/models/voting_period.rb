class VotingPeriod < ActiveRecord::Base
  validates :year, presence: true, uniqueness: true
  def self.current
    order("year DESC").first
  end
end
