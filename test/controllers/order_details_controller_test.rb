require 'test_helper'

class OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_details_index_url
    assert_response :success
  end

end
