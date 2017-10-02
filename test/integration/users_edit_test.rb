require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
  end

  test "unsuccessful email edit" do
    log_in_as(@user)
    patch update_user_email_path(@user), params: { user: { email: 'foo@invalid' } }
    assert_template 'users/edit'
  end

  test "unsuccessful password edit" do
    log_in_as(@user)
    patch update_user_email_path(@user), params: { user: { email: 'foo@invalid' } }
    assert_template 'users/edit'
  end

  test "successful email edit" do
    log_in_as(@user)
    patch update_user_email_path(@user), params: { user: { email: 'foo@valid.com' } }
    assert_equal flash[:success], "Email successfully updated"
    assert_redirected_to user_plays_path(@user)
    @user.reload
    assert_equal @user.email, 'foo@valid.com'
  end

  test "successful password edit" do
    log_in_as(@user)
    patch update_user_password_path(@user), params: { user: { password: 'foobar',
                                                              password_confirmation: 'foobar' } }
    assert_equal flash[:success], "Password successfully updated"
    assert_redirected_to user_plays_path(@user)
    @user.reload
    assert @user.authenticate('foobar')
  end
end
