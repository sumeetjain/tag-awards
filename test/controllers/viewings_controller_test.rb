require 'test_helper'

class ViewingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
  end

  test "update_user should redirect when not logged in" do
    post update_user_viewings_path(@user), params: { play_ids: [] }
    assert_redirected_to login_path
  end

  test "update_user should redirect when logged in as wrong user" do
    log_in_as(users(:user2))
    post update_user_viewings_path(@user), params: { play_ids: [] }
    assert_redirected_to login_path
  end

  test "successfully update user viewings" do
    log_in_as(@user)
    get user_plays_path(@user)
    assert_select "input[type='checkbox']", 30
    assert_select "input[type='checkbox'][checked='checked']", 10
    assert_difference "Viewing.count", -9 do
      post update_user_viewings_path(@user), params: { play_ids: [Play.find_by(title: "Play 1").id] }
    end
    assert_equal flash[:success], "Update successful"
    assert_redirected_to user_plays_path(@user)
    follow_redirect!
    assert_select "input[type='checkbox'][checked='checked']", 1
  end
end
