require "test_helper"
require_relative '../helpers/authorization_helper'

class UserEventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include AuthorizationHelper

  def setup
    test_bank = Bank.create(name: "Coolest Bank")
    test_bank.save
    test_user = User.create(name: "Pepe", username: "pepesrz", password: "SuperSecurePassword", bank_id: test_bank.id)
    test_user.save
  end

  test "It should have a login token with auth helper" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")
    puts credentials
    assert_not false
  end

  test "Should not get to user_events if unauthorized" do
    params = { type: "UserSavedMoney" }
    post '/api/v1/user_events', params: params
    assert_response :unauthorized
  end

  test "It return error if wrong event type" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")

    post '/api/v1/user_events', headers: { Authorization: "Bearer #{credentials["token"]}" }, params: { event: "Wrong" }
    assert_response :bad_request
  end

  test "Should get to user events if authorized" do
    credentials = login_helper(username: "pepesrz", password: "SuperSecurePassword")

    post '/api/v1/user_events', headers: { Authorization: "Bearer #{credentials["token"]}" }
    assert_response :ok
  end
end
