require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#generate_token" do
    context "when token already exists in database" do
      it "generates a unique token" do
        user = User.new
        other_user = User.new(voter_token: user.voter_token)
        other_user.voter_token.wont_equal user.voter_token
      end
    end
  end


  describe UsersController do
      it { should use_before_action(:set_voter_token) }
      end
  
end
