require "test_helper"
require_relative '../helpers/authorization_helper'
require "event_store"

class UserEventsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  def setup
    test_bank = Bank.create(name: "Coolest Bank")
    test_bank.save
    test_user = User.create(name: "Pepe", username: "pepesrz", password: "SuperSecurePassword", bank_id: test_bank.id)
    test_user.save
    reward_manager = RewardManager.create(points: 0, login_streak: 0, user_id: test_user.id)
    reward_manager.save
  end

  test "It should have a login token with auth helper" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")
    assert_not false
  end

  test "Should not get to user_events if user not authenticated" do
    params = { type: "UserSavedMoney" }
    post '/api/v1/user_events', params: params
    assert_response :unauthorized
  end

  test "It return error if wrong event type and user authenticated" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")

    post '/api/v1/user_events', headers: { Authorization: "Bearer #{credentials["token"]}" }, params: { event: "Wrong" }
    assert_response :bad_request
  end

  test "Should get an ok response when sending a USER_AUTHENTICATED event" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")
    now = Time.now.utc
    params = {
      timestamp: now,
      type: EventStore.user_authenticated
    }
    post '/api/v1/user_events', headers: { Authorization: "Bearer #{credentials["token"]}" }, params: params,
                                      as: :json
    assert_response :ok
    assert_not JSON.parse(response.body)["data"].empty?
  end

end
