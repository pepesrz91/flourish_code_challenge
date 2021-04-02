require "test_helper"
require_relative '../helpers/authorization_helper'

class UserEventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include AuthorizationHelper

  def setup
    test_bank = Bank.create(name:"Coolest Bank")
    test_bank.save
    test_user = User.create(name:"Pepe", username:"pepesrz", password:"SuperSecurePassword", bank_id:test_bank.id)
    test_user.save
  end

  test "It should have a login token with auth helper" do
    @credentials = login_helper(username:"pepesrz", password:"SuperSecurePassword")
    assert_not credentials.nil?
  end

  test "Should not get to user_events if unauthorized" do
    params = {type: "UserSavedMoney"}
    post '/api/v1/user_events', params: params
    assert_response :unauthorized
  end

  test "Should get to user events if authorized" do
    params =
  end
end
