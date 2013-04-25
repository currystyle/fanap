require 'test_helper'

class Api::DataControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

end
