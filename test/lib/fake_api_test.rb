require 'test_helper'
require './lib/api_fake'
class FakeApiTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    test_bank = Bank.create(name: 'Coolest Bank')
    test_bank.save
    test_user = User.create(name: 'Pepe', username: 'pepesrz', password: 'SuperSecurePassword', bank_id: test_bank.id)
    test_user.save
    reward_manager = RewardManager.create(points: 0, login_streak: 0, user_id: test_user.id)
    reward_manager.save
  end

  test 'It should return a user accounts properly' do
    fake_api = ApiFake.new
    result = fake_api.query(1)

    assert_not result.nil?

    saving_account = (result.map { |n| n if n[:type] == 'SAVINGS_ACCOUNT' })[0]
    assert saving_account[:type] == "SAVINGS_ACCOUNT"
  end
end