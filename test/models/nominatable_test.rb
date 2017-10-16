require 'test_helper'

class NominatableTest < ActiveSupport::TestCase

  def setup
    @nominatable = Nominatable.new(nominee: Role.first, award: Award.first)
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

  test "nominee and award combination should be unique" do
    @nominatable.save
    new_nominatable = @nominatable.dup
    assert_not new_nominatable.valid?
  end

  test "associated nominations should be destroyed" do
    @nominatable.save
    @nominatable.nominations.create!(user: User.first)
    assert_difference 'Nomination.count', -1 do
      @nominatable.destroy
    end
  end
end
