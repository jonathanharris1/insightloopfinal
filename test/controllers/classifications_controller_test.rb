require "test_helper"

class ClassificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get classifications_index_url
    assert_response :success
  end

  test "should get show" do
    get classifications_show_url
    assert_response :success
  end
end
