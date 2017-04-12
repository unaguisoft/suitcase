require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @another = User.all.where.not(id: @user.id).take if @user
    @user_new_data = {name: 'New name', email: 'new@email.com', role: 'normal',
                      password: 'newpassword', password_confirmation: 'newpassword'}

  end

  test 'should not authorize non admin user' do
    sign_out
    sign_in_as users(:monica)
    get users_path
    assert_redirected_to login_path
  end

  class UserTest < UsersControllerTest
    include AdminUserTestable

    test 'should get index' do
      get users_path
      assert_response :success
      assert_not_nil assigns(:presenter)
      assert_equal User.but(users(:ross).id).count, assigns(:presenter).send(:users).send(:count)
    end

    test "should get new user" do
      get new_user_path
      assert_not_nil assigns(:user)
    end

    test "should create user" do
      assert_difference('User.count', 1) do
        post users_path, params: { user: @user_new_data }
      end
      assert_redirected_to users_path
    end

    test 'should get edit user' do
      get edit_user_path(@another), params: { id: @another }
      assert_response :success
    end

    test "should update user" do
      assert_record_differences(@another, @user_new_data.except(:password, :password_confirmation)) do
        put user_path(@another), params: { id: @another.id, user: @user_new_data }
      end

      assert_redirected_to users_path
    end

    test "should change password" do
      put user_path(@another), params: { id: @another.id, user: @user_new_data }
      user = User.authenticate(@user_new_data[:email], @user_new_data[:password])
      assert_equal user, @another
    end

    test "should destroy another user" do
      assert_difference('User.count', -1) do
        delete user_path(@another), params: { id: @another.id }
      end

      assert_redirected_to users_path
    end

    test "should not destroy user if it is current user" do
      assert_difference('User.count', 0) do
        delete user_path(@user), params: { id: @user.id }
      end

      assert_redirected_to users_path, error: 'No podés eliminarte a vos mismo'
    end
   end

end
