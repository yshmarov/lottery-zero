require "test_helper"

class RoulettesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @roulette = roulettes(:one)
    sign_in @user
  end

  test "should get index" do
    get roulettes_url
    assert_response :success
  end

  test "should get finished roulettes" do
    get finished_roulettes_url
    assert_response :success
  end

  test "should show roulette" do
    get roulette_url(@roulette)
    assert_response :success
  end

  test "should create new bet when gambling" do
    assert_difference("Bet.count") do
      post gamble_roulette_url(@roulette), params: { weight: 1 }
    end

    assert_redirected_to root_path
    assert_equal "You've made a bet!", flash[:notice]
  end

  test "should update existing bet when gambling" do
    existing_bet = bets(:one) # Assuming this belongs to @user and @roulette
    original_weight = existing_bet.weight

    assert_no_difference("Bet.count") do
      post gamble_roulette_url(@roulette), params: { weight: 10 }
    end

    existing_bet.reload
    assert_equal original_weight + 10, existing_bet.weight
  end

  test "should not allow betting more than available shares" do
    post gamble_roulette_url(@roulette), params: { weight: 101 }

    assert_redirected_to root_path
    assert_match /There aren't so many shares left!/, flash[:alert]
  end

  test "should not allow betting more than user balance" do
    @user.update(balance: 5)
    post gamble_roulette_url(@roulette), params: { weight: 10 }

    assert_redirected_to root_path
    assert_match /You don't have enough funds/, flash[:alert]
  end

  test "should not allow monopolizing the bet" do
    post gamble_roulette_url(@roulette), params: { weight: 51 }

    assert_redirected_to root_path
    assert_match /You can't monopolize a bet!/, flash[:alert]
  end

  test "should select winner and create new roulette when completed" do
    @roulette.update(shares_available: 10)

    assert_difference("Roulette.count") do
      post gamble_roulette_url(@roulette), params: { weight: 10 }
    end

    @roulette.reload
    assert_not_nil @roulette.user
    assert_equal "There's a winner!", flash[:notice]
  end
end
