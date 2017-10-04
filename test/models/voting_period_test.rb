require 'test_helper'

class VotingPeriodTest < ActiveSupport::TestCase

  def setup
    @voting_period = VotingPeriod.new(year: 1, active: true)
  end

  test "should be valid" do
    assert @voting_period.valid?
  end

  test "year should be present" do
    @voting_period.year = nil
    assert_not @voting_period.valid?
  end

  test "year should be unique" do
    new_voting_period = @voting_period.dup
    @voting_period.save
    assert_not new_voting_period.valid?
  end

  test "active should be present" do
    @voting_period.active = nil
    assert_not @voting_period.valid?
  end
end
