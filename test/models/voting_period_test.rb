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

  test "nominations_active should be present" do
    @voting_period.nominations_active = nil
    assert_not @voting_period.valid?
  end

  test "voting_active should be present" do
    @voting_period.voting_active = nil
    assert_not @voting_period.valid?
  end

  test "associated plays should be destroyed" do
    @voting_period.save
    @voting_period.plays.create!(title: "FakeTitle", theater_id: Theater.first.id)
    assert_difference 'VotingPeriod.count', -1 do
      @voting_period.destroy
    end
  end
end
