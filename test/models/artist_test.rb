require 'test_helper'

class ArtistTest < ActiveSupport::TestCase

  def setup
    @artist = artists(:artist1)
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
end
