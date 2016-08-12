require 'rails_helper'

RSpec.describe VotingPeriod, type: :model do
  it "is valid with a year"
  it "is invalid without a year"
  it "is invalid with a duplicate year"
  it "gets the most recent year as the current year"
  it "defaults the ballot status to pending"
  it "is valid with a ballot status of pending"
  it "is valid with a ballot status of nominations"
  it "is valid with a ballot status of voting"
  it "is valid with a ballot status of closed"
end
