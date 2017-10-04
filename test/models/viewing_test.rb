require 'test_helper'

class ViewingTest < ActiveSupport::TestCase

  def setup
    @viewing = Viewing.new(user_id: User.first.id, play_id: Play.first.id)
  end

  test "should be valid" do
    assert @viewing.valid?
  end

  test "user_id should be present" do
    @viewing.user_id = nil
    assert_not @viewing.valid?
  end

  test "play_id should be present" do
    @viewing.play_id = nil
    assert_not @viewing.valid?
  end

  test "user should exist" do
    @viewing.user_id = 500
    assert_not @viewing.valid?
  end

  test "play should exist" do
    @viewing.play_id = 500
    assert_not @viewing.valid?
  end

  test "duplicates should not be valid" do
    new_viewing = @viewing.dup
    @viewing.save
    assert_not new_viewing.valid?
  end
end
