require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user=>{:login=>@user.login+"2", :password=>@user.password+"2"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should not get edit" do
    get :edit, id: @user
    assert_response :redirect
	assert_redirected_to "/"
  end

  test "should not update user" do
    put :update, id: @user, user: @user.attributes
    assert_redirected_to "/"
  end

  test "should not destroy user" do
	delete :destroy, id: @user
	assert :redirect
    assert_redirected_to "/" 
  end
end
