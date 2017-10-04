require 'test_helper'

class TheaterTest < ActiveSupport::TestCase

  def method_name
    @theater = Theater.new(name: "Red Barn")
  end

  test "should be valid" do
    assert @theater.valid?
  end

  test "name should be present" do
    @theater.name = "   "
    assert_not @theater.valid?
  end

  test "name should be unique" do
    duplicate_theater = @theater.dup
    @theater.save
    assert_not duplicate_theater.valid?
  end

  test "name should not be too long" do
    @theater.name = 'a' * 256
    assert_not @theater.valid?
  end

  test "dependent plays should be destroyed" do
    @theater.save
    @theater.plays.create!(title: 'FakeTitle', voting_period_id: VotingPeriod.first.id)
    assert_difference 'Play.count', -1 do
      @theater.destroy
    end
  end
end
