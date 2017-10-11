require 'test_helper'

class NominationTest < ActiveSupport::TestCase

  def setup
    @nomination = Nomination.new(user: User.first, nominatable: Nominatable.first)
  end

  test "should be valid" do
    assert @nomination.valid?
  end

  test "nominatable_id should be present" do
    @nomination.nominatable = nil
    assert_not @nomination.valid?
  end

  test "user_id should be present" do
    @nomination.user = nil
    assert_not @nomination.valid?
  end

  test "user and nominatable combination should be unique" do
    @nomination.save
    new_nomination = @nomination.dup
    assert_not new_nomination.valid?
  end
end
