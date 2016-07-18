class VotingPeriod < ActiveRecord::Base
  def self.current
    order("year DESC").first
  end
end
