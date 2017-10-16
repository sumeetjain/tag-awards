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

  test "associated viewings should be destroyed" do
    @play.save
    @play.viewings.create!(user_id: User.first.id)
    assert_difference 'Viewing.count', -1 do
      @play.destroy
    end
  end

  test "associated roles should be destroyed" do
    @play.save
    @play.roles.create!(artist: Artist.first, character: 'Test', job_kind: 'Actor')
    assert_difference 'Role.count', -1 do
      @play.destroy
    end
  end

  test "associated nominatables should be destroyed" do
    @play.save
    @play.nominatables.create!(award: Award.first, display_name: "Test")
    assert_difference 'Nominatable.count', -1 do
      @play.destroy
    end
  end

  test "for_current_voting_period should return plays for the active voting period" do
    plays = Play.for_current_voting_period
    assert_equal plays.count, 30
    assert_not plays.any? { |play| !play.voting_period.active }
  end

  test "display_name" do
    @play.theater = theaters(:theater_1)
    assert_equal @play.display_name, "Who's Afraid of the Big Bad Woolf?, Theater 1"
  end
end
