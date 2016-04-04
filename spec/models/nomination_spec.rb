require 'rails_helper'

RSpec.describe Nomination, type: :model do

  # TODO read more about when it is appropriate to use FactoryGirl and how I should create the appropriate setup for these tests. 

  describe "#weight" do
    before { @user = User.create(first_name: "Tom", last_name: "Hanks", password: "Password123", email: "tom@gmail.com") }
    before { @nomination = Nomination.create(user_id: @user.id)}
    before { FactoryGirl.create_list(:viewing, 11, user_id: @user.id) }
      it "returns the correct voter weight for user based on viewings" do
        expect(@nomination.weight).to eq(2)
      end
  end

  describe ".rank_by_voter_weight" do
    before { @user = User.create(first_name: "Tom", last_name: "Hanks", password: "Password123", email: "tom@gmail.com") }
    before { @other_user = User.create(first_name: "Bob", last_name: "Ross", password: "Password123", email: "bob@gmail.com") }
    before { @nomination = Nomination.create(user_id: @user.id)}
    before { @other_nomination = Nomination.create(user_id: @other_user.id)}
    before { FactoryGirl.create_list(:viewing, 11, user_id: @user.id) }
    before { FactoryGirl.create_list(:viewing, 25, user_id: @other_user.id) }
    
      it "returns all nominations ordered by voter weight" do
        expect(Nomination.rank_by_voter_weight).to eq([@nomination, @other_nomination])
      end    
  end

end
