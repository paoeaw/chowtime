require 'test_helper'

class MealsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get meals_show_url
    assert_response :success
  end

end
