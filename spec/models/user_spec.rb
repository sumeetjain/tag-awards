require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#nomination_value" do
    context "when this nomination was previously saved" do
      it "returns the proper string of the previous nomination" do
        @user1 = User.new
        @user1.id = 2
        @nom1 = Nomination.new
        @nom1.nominee = "Grace Bydalek"
        @nom1.role = "Natalie"
        @nom1.show = "Next to Normal"
        @nom1.theater = "Shelterbelt"
        @nom1.user_id = @user1.id
        @nom1.award_id = 1
        assert_equal("Grace Bydalek", @user1.nomination_value(1, 1, "nominee"))
        assert_equal("Shelterbelt", @user1.nomination_value(1, 1, "theater"))
      end
    end
  end


end