require 'rails_helper'

RSpec.describe Nomination, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    @user = User.new(first_name: "Ryan")
    @nomination = Nomination.new(user_id: @user.id)
    @viewing_1 = Viewing.new(user_id: @user.id)
    @viewing_2 = Viewing.new(user_id: @user.id)
    @viewing_3 = Viewing.new(user_id: @user.id)

  end 

  describe "#weight" do
    context "when user has three viewings" do
      it "changes according to viewings.count" do
        expect(@nomination.weight).to eq(1)
      end 
    end 
  end



end