require "test_helper"

class ChargesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get new_charge_path
    assert_response :success
    assert_select "form[action=?]", charges_path
  end

  test "should create charge with valid params" do
    assert_difference("Charge.count") do
      post charges_path, params: { charge: { amount: 100 } }
    end
    assert_response :redirect
  end

  test "should not create charge with invalid params" do
    assert_no_difference("Charge.count") do
      post charges_path, params: { charge: { amount: nil } }
    end

    assert_response :unprocessable_entity
  end
end
