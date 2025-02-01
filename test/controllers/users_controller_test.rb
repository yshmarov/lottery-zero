require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)  # Assuming you have a user fixture
    sign_in @user
  end

  test "get" do
    get users_url
    assert_response :success
  end

  test "show" do
    get user_url(@user)
    assert_response :success
  end
end
