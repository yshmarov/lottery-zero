require "test_helper"

class BasicControllerTest < ActionDispatch::IntegrationTest
  test "should get landing_page" do
    get root_path
    assert_redirected_to new_user_session_path
  end
end
