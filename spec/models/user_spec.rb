require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#nomination_value" do
      it "returns the proper string of the previous nomination"
        @user1 = User.new
        @user1.id = 2
        @nom1 = Nomination.new
        @nom1.nominee = "Grace Bydalek"
        @nom1.role = "Natalie"
        @nom1.show = "Next to Normal"
        @nom1.theater = "Shelterbelt"
        @nom1.user_id = @user1.id
        @nom1.award_id = 1
        expect("Grace Bydalek").to_include(@user1.nomination_value(1, 1, "nominee"))
        expect("Shelterbelt").to_include(@user1.nomination_value(1, 1, "theater"))
      end
  end



