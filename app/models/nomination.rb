class Nomination < ActiveRecord::Base
  belongs_to :potential_nomination
  accepts_nested_attributes_for :potential_nomination
  belongs_to :user

  # validates :potential_nomination, uniqueness: { scope: :user, message: "You may only nominate something once!"}

  def self.nominations_closed
    # Nomination.where(open: false).count > 0
    false
  end

  # User weights are never set - should grab weights from user?
  # Nomination now has a potential nomination instead of listing theater, show, etc

  # Returns AR Relation for top ten nominees for a given award.
  # def self.top_ten(award_id, limit=10)
  #   joins(:user)
  #   .select("theater, show, nominee, role, 
  #     count(*) as raw_count, sum(users.weight) as weighted_count")
  #   .where(award_id: award_id, approved: true)
  #   .group("1, 2, 3, 4")
  #   .order("weighted_count desc, raw_count desc")
  #   .limit(limit)
  # end

  def self.top_ten(award_id, limit=10)
    joins(:user)
    .select("potential_nomination_id, 
      count(*) as raw_count, sum(users.viewings_weight) as weighted_count")
    .where(potential_nomination.award_id: award_id)
    .group("1")
    .order("weighted_count desc, raw_count desc")
    .limit(limit)
  end

  def saveBallotItems(params)
      award = Award.find(params[:id])
      finalists = []

      params[:ballot][:finalists].values.each do |finalist|
        if !finalist["info"].nil?
          potential_nomination_id = finalist["info"]
          finalist_hash = {
              potential_nomination_id: potential_nomination_id,
              award_id: params[:id],
              #hard coded -- need to figure out how to integrate this.
              voting_period: 2
            }
            finalists << finalist_hash
          end
        end
      end
      BallotItem.create(finalists)
      award.update(ballot_set: true)
    end

end
