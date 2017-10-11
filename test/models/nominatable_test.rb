require 'test_helper'

class NominatableTest < ActiveSupport::TestCase

  def setup
    @nominatable = Nominatable.new(nominee: Role.first, award: Award.first,
                                   display_name: "Nominate me!")
  end

  test "should be valid" do
    assert @nominatable.valid?
  end

  test "award_id should be present" do
    @nominatable.award_id = nil
    assert_not @nominatable.valid?
  end

  test "nominee should be present" do
    @nominatable.nominee = nil
    assert_not @nominatable.valid?
  end

  test "display_name should be valid" do
    @nominatable.display_name = nil
    assert_not @nominatable.valid?
  end

  test "display_name should not be too long" do
    @nominatable.display_name = 'a' * 101
    assert_not @nominatable.valid?
  end
end
