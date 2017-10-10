require 'test_helper'

class ArtistTest < ActiveSupport::TestCase

  def setup
    @artist = Artist.new(name: 'Artist2')
  end

  test "should be valid" do
    assert @artist.valid?
  end

  test "name should be present" do
    @artist.name = "   "
    assert_not @artist.valid?
  end

  test "name should not be too long" do
    @artist.name = 'a' * 51
    assert_not @artist.valid?
  end

  test "associated roles should be destroyed" do
    @artist.save
    @artist.roles.create!(play: Play.first, name: 'Test', job_type: 'Director')
    assert_difference 'Role.count', -1 do
      @artist.destroy
    end
  end
end
