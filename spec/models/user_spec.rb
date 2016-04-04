require 'rails_helper'

RSpec.describe User, type: :model do

# I am pretty sure this is an incorrect usage. I should probably be calling #generate_token directly in the test instead of relying on the before filter. This would perhaps be better suited for the controller spec?

  describe "#generate_token" do
    context "when users get created" do
      it "generates a unique token" do
        user = User.create!(first_name: "Tom", last_name: "Hanks", password: "Password123", email: "tom@gmail.com")
        other_user = User.create!(first_name: "Fred", last_name: "Fred", password: "Password123", email: "fred@gmail.com")
        expect(user.voter_token).to_not eq(other_user.voter_token)
      end
    end
  end

  describe "#weight" do
    before { @user = User.create(first_name: "Tom", last_name: "Hanks", password: "Password123", email: "tom@gmail.com") }
    before { @nomination = Nomination.create(user_id: @user.id)}
    before { FactoryGirl.create_list(:viewing, 11, user_id: @user.id) }
      it "returns the correct voter weight for user based on viewings" do
        expect(@nomination.weight).to eq(2)
      end
  end


  
end
