require "test_helper"

class ImprovementsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get improvements_create_url
    assert_response :success
  end

  test "should get index" do
    get improvements_index_url
    assert_response :success
  end

  test "should get show" do
    get improvements_show_url
    assert_response :success
  end
end
