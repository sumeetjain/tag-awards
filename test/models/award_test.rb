require 'test_helper'

class AwardTest < ActiveSupport::TestCase

  def setup
    @award = Award.new(name: 'Worst Performance', description: 'This artist is just really, really terrible.',
                       award_kind: :acting)
  end

  test "should be valid" do
    assert @award.valid?
  end

  test "name should be present" do
    @award.name = "   "
    assert_not @award.valid?
  end

  test "description should be present" do
    @award.description = "   "
    assert_not @award.valid?
  end

  test "award_kind should be present" do
    @award.award_kind = nil
    assert_not @award.valid?
  end

  test "name should be unique" do
    @award.save
    new_award = Award.new(name: 'Worst Performance', description: 'This artist gave it their all but failed
                          miserably.', award_kind: :production)
    assert_not new_award.valid?
  end

  test "name should not be too long" do
    @award.name = 'a' * 101
    assert_not @award.valid?
  end
end
