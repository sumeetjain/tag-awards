require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @user2 = users(:user2)
  end

  test 'user plays path' do
    log_in_as(@user)
    get user_plays_path(@user)
    assert_template 'users/plays'
  end

  test 'edit user path' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
  end

  test 'should redirect plays when not logged in' do
    get user_plays_path(@user)
    assert_redirected_to login_path
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_redirected_to login_path
  end

  test 'should redirect update when not logged in' do
    patch update_user_email_path(@user), params: { user: { email: 'foo@valid.com' } }
    assert_redirected_to login_url
    patch update_user_email_path(@user), params: { user: { password: 'foobar',
                                                           password_confirmation: 'foobar' } }
    assert_redirected_to login_path
  end

  test "should redirect plays when logged in as wrong user" do
    log_in_as(@user)
    get user_plays_path(@user2)
    assert_redirected_to root_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user)
    get edit_user_path(@user2)
    assert_redirected_to root_path
  end

  test "should redirect email update when logged in as wrong user" do
    log_in_as(@user)
    patch update_user_email_path(@user2), params: { user: { email: 'foo@valid.com' } }
    assert_redirected_to root_path
  end

  test "should redirect password update when logged in as wrong user" do
    log_in_as(@user)
    patch update_user_password_path(@user2), params: { user: { password: 'foobar',
                                                              password_confirmation: 'foobar' } }
    assert_redirected_to root_path
  end
end
