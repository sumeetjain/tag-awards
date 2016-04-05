class BallotItem < ActiveRecord::Base

belongs_to :award
belongs_to :play

# play_id == convergence of play title and theater
  def approved_ballot
    ballot = BallotItem.new
    approved_nominations = Nomination.where({"approved" => true})

    approved_nominations.each do |nom|
      ballot.nominee  = nom.nominee
      ballot.role     = nom.role
      ballot.award_id = nom.award_id
      ballot.play_id  = Play.where("theater == ? AND title == ?", nom.theater, nom.show).id

      ballot.save
    end
  end 

end
