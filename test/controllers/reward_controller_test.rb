require "test_helper"
require_relative '../helpers/authorization_helper'

class RewardControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  def setup
    test_bank = Bank.create(name: 'Coolest Bank')
    test_bank.save

    @reward1 = Reward.create(name: "2 Movie Tickets", price: 1500, bank_id: test_bank.id)
    @reward1.save
    reward2 = Reward.create(name: "Free Massage", price: 1000, bank_id: test_bank.id)
    reward2.save

    test_user = User.create(name: 'Pepe', username: 'pepesrz', password: 'SuperSecurePassword', bank_id: test_bank.id)
    test_user.save
    reward_manager = RewardManager.create(points: 2000, login_streak: 0, user_id: test_user.id)
    reward_manager.save
  end

  test "It should not get to rewards endpoint if user is not authenticated" do
    params = { type: 'UserSavedMoney' }
    get '/api/v1/rewards', params: params
    assert_response :unauthorized
  end
  test "It should return an array of available rewards" do
    credentials = login_helper(username: 'pepesrz', password: 'SuperSecurePassword')
    get '/api/v1/rewards', headers: { Authorization: "Bearer #{credentials["token"]}" }
    assert_response :ok
    rewards = JSON.parse(response.body)["available_rewards"]
    assert rewards.count >= 2
  end
  test "It should reedem a reward correctly" do
    credentials = login_helper(username: 'pepesrz', password: 'SuperSecurePassword')
    params ={
      reward_id: @reward1.id
    }
    post '/api/v1/user/redeems/', headers: { Authorization: "Bearer #{credentials["token"]}" }, params:params
    assert_response :created
    rewards = JSON.parse(response.body)
    assert_not rewards["user_redeemed_reward"].nil?
  end
end
