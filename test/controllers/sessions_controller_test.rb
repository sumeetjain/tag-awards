require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
  end

  test 'should redirect new if logged in' do
    log_in_as(@user)
    get login_path
    assert_redirected_to plays_path
  end
end
