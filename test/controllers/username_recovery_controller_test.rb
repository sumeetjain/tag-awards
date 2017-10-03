require 'test_helper'

class UsernameRecoveryControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    ActionMailer::Base.deliveries.clear
  end

  test 'should redirect new if logged in' do
    log_in_as(@user)
    get new_username_recovery_path
    assert_redirected_to user_plays_path(@user)
  end

  test 'should send email if usernames found' do
    post username_recovery_index_path, params: { email: 'josh@example.com' }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_equal flash[:success], "Please check your email."
    assert_redirected_to new_username_recovery_path
  end

  test 'should not send email if usernames not found' do
    post username_recovery_index_path, params: { email: 'fake@fake.fake' }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_equal flash[:danger], "No usernames found for that email address."
    assert_redirected_to new_username_recovery_path
  end
end
