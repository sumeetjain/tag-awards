require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#generate_token" do
    context "when token already exists in database" do
      it "generates a unique token" do
        user = User.create!(first_name: "Tom", last_name: "Hanks", password: "Password123", email: "tom@gmail.com")
        other_user = User.create!(first_name: "Fred", last_name: "Fred", password: "Password123", email: "fred@gmail.com")
        other_user.voter_token.wont_equal user.voter_token
      end
    end
  end




  
end
