require 'test_helper'

class Admin::ItemControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

end
