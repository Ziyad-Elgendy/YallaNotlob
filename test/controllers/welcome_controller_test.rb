require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get showFriends" do
    get welcome_showFriends_url
    assert_response :success
  end

end
