require 'test_helper'

class DosesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doses_index_url
    assert_response :success
  end

end
