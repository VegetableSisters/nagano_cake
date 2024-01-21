require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get suggest" do
    get search_suggest_url
    assert_response :success
  end
end
