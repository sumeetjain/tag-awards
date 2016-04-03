require 'rails_helper'

RSpec.describe Nomination, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#weight" do
    context "when user has three viewings" do
      it "changes according to viewings.count" do
        user = User.new
        first_play = Play.new(title: "Planet of the Apes")
        second_play = Play.new(title: "Fiddler on the Roof")
        third_play = Play.new(title: "Steve Jobs")
        viewing_1 = Viewing.new(play_id: first_play.id, user_id: user.id)
        viewing_2 = Viewing.new(play_id: second_play.id, user_id: user.id)
        viewing_3 = Viewing.new(play_id: third_play.id, user_id: user.id)
        nomination = Nomination.new(user_id: user.id)
        expect (nominaton.weight).to eq(1)
      end 
    end 
  end

end