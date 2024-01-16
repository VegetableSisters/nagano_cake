require "test_helper"

class Admin::OrdersDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_orders_details_update_url
    assert_response :success
  end
end
