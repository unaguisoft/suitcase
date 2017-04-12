require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @me = users(:ross)
  end

  test "should get login" do
    get login_path
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should create session" do
    post user_sessions_path, params: { email: @me.email, password: 'friends' }
    assert logged_in?
    assert_equal @me, assigns(:user)
    assert_redirected_to root_path
  end

  test 'should not create session' do
    post user_sessions_path, params: { email: @me.email, password: 'wrong' }
    assert_not logged_in?
  end

  test "should logout" do
    sign_in_as(@me)

    assert logged_in?
    post logout_path
    assert_not logged_in?
    assert_redirected_to login_path
  end


end
