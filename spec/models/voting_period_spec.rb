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
    period = VotingPeriod.new
    period.year = 2016
    period.save

    duplicate = VotingPeriod.new
    duplicate.year = 2016
    expect(duplicate.valid?).to be(false)
  end
  it "gets the most recent year as the current year" do
    period1 = VotingPeriod.new
    period1.year = 2016
    period1.save

    period2 = VotingPeriod.new
    period2.year = 2015
    period2.save

    expect(VotingPeriod.current.year).to eq(2016)
  end
  it "defaults the ballot status to pending" do
    period = VotingPeriod.new
    period.year = 2016
    
    expect(period.ballot_status).to eq("pending")  
  end
  xit "is valid with a ballot status of pending" do

  end
  xit "is valid with a ballot status of nominations" do

  end
  xit "is valid with a ballot status of voting" do

  end
  xit "is valid with a ballot status of closed" do

  end
  xit "is invalid with a different ballot status" do

  end
end
