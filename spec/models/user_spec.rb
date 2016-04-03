require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#nomination_value" do
    context "when user has previously saved this nomination" do
      it "returns the proper string of the previous nomination"
        @nom1 = Nomination.new
        @nom1.nominee = "Grace Bydalek"
        @nom1.role = "Natalie"
        @nom1.show = "Next to Normal"
        @nom1.theater = "Shelterbelt"
        @nom1.user_id = 2
        @nom1.award_id = 1
        assert_equal("Grace Bydalek", nomination_value(1, 1, "nominee"))
        assert_equal("Shelterbelt", nomination_value(1, 1, "theater"))
      end
    end

  end




end
