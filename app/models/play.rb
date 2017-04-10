class Play < ActiveRecord::Base
  has_many :roles
  belongs_to :theater
  belongs_to :voting_period
  has_many :viewings
  has_many :ballot_items
  has_many :potential_nominations, as: :nominatable

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }

  scope :for_current_voting_period, ->  { joins(:voting_period)
    .where("voting_periods.year = ?", Time.now.strftime("%Y")).order(title: :asc)}

  def display_name
    "#{title}, #{theater.try(:name)}"
  end
end
