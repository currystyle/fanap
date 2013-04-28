require 'test_helper'

class Admin::NotifyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get test" do
    get :test
    assert_response :success
  end

  test "should get push" do
    get :push
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
