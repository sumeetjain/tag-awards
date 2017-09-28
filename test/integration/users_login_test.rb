require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
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

  test "login with valid information followed by logout" do
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
  end
end
