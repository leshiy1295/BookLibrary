require 'test_helper'

class Dz3ControllerTest < ActionController::TestCase
  test "should get poisk" do
    get :poisk
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
