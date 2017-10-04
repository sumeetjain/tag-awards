require 'test_helper'

class PlayTest < ActiveSupport::TestCase

  def setup
    @play = Play.new(title: "Who's Afraid of the Big Bad Woolf?",
                     voting_period_id: VotingPeriod.first.id,
                     theater_id: Theater.first.id)
  end

  test "should be valid" do
    assert @play.valid?
  end

  test "title should be present" do
    @play.title = "   "
    assert_not @play.valid?
  end

  test "title should not be too long" do
    @play.title = 'a' * 256
    assert_not @play.valid?
  end

  test "voting_period_id should be present" do
    @play.voting_period_id = nil
    assert_not @play.valid?
  end

  test "theater_id should be present" do
    @play.theater_id = nil
    assert_not @play.valid?
  end

  test "voting_period should exist" do
    @play.voting_period_id = 500
    assert_not @play.valid?
  end

  test "theater should exist" do
    @play.theater_id = 500
    assert_not @play.valid?
  end

  test "duplicates should not be valid" do
    new_play = @play.dup
    @play.save
    assert_not new_play.valid?  
  end
end
