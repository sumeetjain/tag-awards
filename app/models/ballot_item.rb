class BallotItem < ActiveRecord::Base

belongs_to :award
belongs_to :play

# play_id == convergence of play title and theater
  def self.approved_ballots
    ballot = BallotItem.new
    approved_nominations = Nomination.where({"approved" => true})

    approved_nominations.each do |nom|
      ballot.nominee  = nom.nominee
      ballot.role     = nom.role
      ballot.award_id = nom.award_id
      ballot.play_id  = Play.where("theater_id == ? AND title == ?", Theater.find_by_name(nom.theater).id, nom.show).ids

      ballot.save
    end
  end 

end
