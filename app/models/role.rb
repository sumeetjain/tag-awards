class Role < ActiveRecord::Base
  belongs_to :artist
  belongs_to :play
  belongs_to :voting_period
  belongs_to :potential_nomination

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  enum job: ["director", "actor", "actress", "music director", "choreographer",
    "sound designer", "props designer", "set designer", "costume designer", 
    "lighting designer", "ensemble", "writer", "other"]
end