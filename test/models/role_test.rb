require 'test_helper'

class RoleTest < ActiveSupport::TestCase

  def setup
    @role = Role.new(artist: Artist.first, play: Play.first, character: 'Test',
                     job_kind: 'Actor')
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
    @role.job_kind = nil
    assert_not @role.valid?
  end

  test "character should not be too long" do
    @role.character = 'a' * 51
    assert_not @role.valid?
  end

  test "character, artist_id, play_id, and job_kind combination should be unique" do
    @role.save
    new_role = @role.dup
    assert_not new_role.valid?
  end

  test "associated nominatables should be destroyed" do
    @role.save
    @role.nominatables.create!(award: Award.first, display_name: "Test")
    assert_difference 'Nominatable.count', -1 do
      @role.destroy
    end
  end

  test "display_name if character present" do
    @role.artist = artists(:artist_1)
    @role.play = plays(:play_1)
    assert_equal @role.display_name, "Artist 1 as Test, Play 1, Theater 2"
  end

  test "display_name without character" do
    @role.character = nil
    @role.play = plays(:play_1)
    assert_equal @role.display_name, "Artist 1 - Actor, Play 1, Theater 2"
  end
end
