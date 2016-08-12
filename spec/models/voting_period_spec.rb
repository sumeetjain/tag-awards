require 'rails_helper'

RSpec.describe VotingPeriod, type: :model do
  it "is valid with a year" do
    period = VotingPeriod.new
    period.year = 2016
    expect(period.valid?).to be(true)
  end
  it "is invalid without a year" do
    period = VotingPeriod.new
    period.year = 
    expect(period.valid?).to be(false)
  end
  it "is invalid with a duplicate year" do

  end
  it "gets the most recent year as the current year" do

  end
  it "defaults the ballot status to pending" do

  end
  it "is valid with a ballot status of pending" do

  end
  it "is valid with a ballot status of nominations" do

  end
  it "is valid with a ballot status of voting" do

  end
  it "is valid with a ballot status of closed" do

  end
  it "is invalid with a different ballot status" do

  end
end
