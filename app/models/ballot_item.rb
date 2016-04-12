class BallotItem < ActiveRecord::Base

belongs_to :award
belongs_to :play

  def create
    nomination = Nomination.ranked_by_weight
    @ballot_item = BallotItem.new

    nomination.each do |nom,weight|
      @ballot_item.nominee  = nom.nominee
      @ballot_item.role     = nom.role
      @ballot_item.award_id = nom.award_id
      @ballot_item.play_id  = Play.find_by_title(nom.show).id
      
      @ballot_item.save
    end
  end
end
