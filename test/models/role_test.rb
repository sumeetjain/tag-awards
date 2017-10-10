require 'test_helper'

class RoleTest < ActiveSupport::TestCase

  def setup
    @role = Role.new(artist: Artist.first, play: Play.first, name: 'Test',
                     job_type: 'Actor')
  end

  test "should be valid" do
    assert @role.valid?
  end

  test "artist_id should be present" do
    @role.artist_id = nil
    assert_not @role.valid?
  end

  test "play_id should be present" do
    @role.play_id = nil
    assert_not @role.valid?
  end

  test "job should be present" do
    @role.job_type = nil
    assert_not @role.valid?
  end

  test "name should be present" do
    @role.name = "   "
    assert_not @role.valid?
  end

  test "name should not be too long" do
    @role.name = 'a' * 51
    assert_not @role.valid?
  end

  test "name, artist_id, and play_id combination should be unique" do
    @role.save
    new_role = Role.new(name: "Test", artist: Artist.first,
                        play: Play.first, job_type: 'Actress')
    assert_not new_role.valid?
  end
end
