require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    p root_url
    p root_path
    get root_path
    # p response.body
    assert_response :success
  end

  test "should get home II" do
    get root_path
    sleep 0.1
    # p response.body
    assert_response :success
  end
end
