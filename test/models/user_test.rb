require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'example', full_name: 'Example User',
                     email: 'example@foo.bar', password: 'foobar',
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "full_name should be present" do
    @user.full_name = "     "
    assert_not @user.valid?
  end

  test "admin should be present" do
    @user.admin = nil
    assert_not @user.valid?
  end

  test "membership_active should be present" do
    @user.membership_active = nil
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "full_name should not be too long" do
    @user.full_name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "usernames should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated viewings should be destroyed" do
    @user.save
    @user.viewings.create!(play_id: Play.first.id)
    assert_difference 'Viewing.count', -1 do
      @user.destroy
    end
  end

  test "associated nominations should be destroyed" do
    @user.save
    @user.nominations.create!(nominatable: Nominatable.first)
    assert_difference "Nomination.count", -1 do
      @user.destroy
    end
  end

  test "should return a list of viewings for the current voting period" do
    user = users(:josh)
    viewings = user.current_voting_period_viewings
    assert_equal viewings.length, 10
    viewings.each { |viewing| assert_equal viewing.play.voting_period.active, true }
  end

  test "has_viewed should return true if the user has viewed the play and false otherwise" do
    user = users(:josh)
    play = Play.find_by(title: "Play 3")
    assert user.has_viewed? play
    play = Play.find_by(title: "Play 4")
    assert_not user.has_viewed? play
  end

  test "insert_viewings should add viewings to the database for the given play ids" do
    user = users(:josh)
    play_ids = [Play.find_by(title: "Play 1").id, Play.find_by(title: "Play 2").id]
    assert_difference "Viewing.count", 2 do
      user.insert_viewings play_ids
    end
  end
end
