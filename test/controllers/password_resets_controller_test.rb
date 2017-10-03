require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @other_user = users(:user2)
    ActionMailer::Base.deliveries.clear
  end

  test 'should redirect if logged in' do
    log_in_as(@user)
    get new_password_reset_path
    assert_redirected_to user_plays_path(@user)
    get edit_password_reset_path(@user)
    assert_redirected_to user_plays_path(@user)
  end

  test "should not send email if username not found" do
    post password_resets_path, params: { username: "fakename" }
    assert_equal flash[:danger], "Username not found."
    assert_redirected_to new_password_reset_path
  end

  test "should send email if username found" do
    post password_resets_path, params: { username: @user.username }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal ActionMailer::Base.deliveries.size, 1
    assert_equal flash[:success], "Please check your email."
    assert_redirected_to root_url
  end

  test "edit redirects if wrong username" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, username: "")
    assert_redirected_to root_url
  end

  test "update redirects if wrong username" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { username: @other_user.username,
                    user: { password: 'password',
                            password_confirmation: 'password' } }
    assert_redirected_to root_url
  end

  test "edit redirects if wrong token" do
    @user.create_reset_digest
    get edit_password_reset_path("Fake token", username: @user.username)
    assert_redirected_to root_url
  end

  test "update redirects if wrong token" do
    @user.create_reset_digest
    patch password_reset_path('wrong_token'),
          params: { username: @user.username,
                    user: { password: 'password',
                            password_confirmation: 'password' } }
    assert_redirected_to root_url
  end

  test 'edit redirects if token expired' do
    @user.create_reset_digest
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    @user.reload
    get edit_password_reset_path(@user.reset_token, username: @user.username)
    assert_redirected_to new_password_reset_path
  end

  test 'update redirects if token expired' do
    @user.create_reset_digest
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    @user.reload
    patch password_reset_path(@user.reset_token),
          params: { username: @user.username,
                    user: { password: 'password',
                            password_confirmation: 'password' } }
    assert_redirected_to new_password_reset_path
  end

  test "error if invalid password and confirmation submitted" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { username: @user.username,
                    user: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_template 'password_resets/edit'
  end

  test "error if empty password submitted" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { username: @user.username,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_template 'password_resets/edit'
  end

  test "update password, clear reset digest, and redirect to user plays
        if valid password and confirmation submitted" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { username: @user.username,
                    user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_equal flash[:success], "Password has been reset."
    assert_redirected_to user_plays_path(@user)
    @user.reload
    assert_nil @user.reset_digest
  end
end
