require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @not_active = users(:user2)
  end

  test "login with invalid information" do
    get root_path
    assert_template 'sessions/new'
    post login_path, params: { session: { username: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information and active membership followed by logout" do
    get login_path
    post login_path, params: { session: { username: @user.username,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to plays_url
    follow_redirect!
    assert_template 'users/plays'
    assert_select 'a[href=?]', logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
  end

  test "login with valid information and inactive membership" do
    get login_path
    post login_path, params: { session: { username: @not_active.username,
                                          password: 'password' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
