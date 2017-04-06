class Nomination < ActiveRecord::Base
  belongs_to :potential_nomination
  accepts_nested_attributes_for :potential_nomination
  belongs_to :user

  validates :potential_nomination, uniqueness: { scope: :user, message: "You may only nominate something once!"}

  scope :for_voting_period, -> (voting_period) { joins(:voting_period)
    .where("voting_periods.year = ?", voting_period) }


  # User weights are never set - should grab weights from user?
  # Nomination now has a potential nomination instead of listing theater, show, etc

  def self.top_ten(award_id, limit=10)
    self.joins(:user, :potential_nomination)
    .select("potential_nomination_id, count(*) as raw_count, sum(users.weight) as weighted_count")
    .group("potential_nomination_id")
    .order("weighted_count desc, raw_count desc")
    .limit(limit)
    .where(created_at: 40.days.ago..Time.current)
    .where(potential_nominations: {award_id: award_id})
  end

  def self.saveBallotItems(params)
    award = Award.find(params[:id])
    finalists = []

    params[:ballot][:finalists].values.each do |finalist|
      if !finalist["info"].nil?
        potential_nomination_id = finalist["info"]
        finalist_hash = {
            potential_nomination_id: potential_nomination_id,
            award_id: params[:id],
            #hard coded -- need to figure out how to integrate this.
            voting_period_id: 2
        }
        finalists << finalist_hash
      end
    end
    BallotItem.create(finalists)
    award.update(ballot_set: true)
  end

end
