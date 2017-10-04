class VotingPeriod < ApplicationRecord
  validates :year, presence: true, uniqueness: true
  validates :active, presence: true
end
