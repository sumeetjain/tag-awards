require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "username_recovery" do
    email = 'josh@example.com'
    mail = UserMailer.username_recovery(email)
    assert_equal "Username recovery", mail.subject
    assert_equal ["josh@example.com"], mail.to
    assert_equal ["tagawards@noreply.com"], mail.from
    User.where(email: email).each do |user|
      assert_match user.username, mail.body.encoded
    end
  end

  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
