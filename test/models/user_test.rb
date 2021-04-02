require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test 'It should not create a new user without password' do
    user = User.new
    user.save
    assert_not user.valid?
  end

  test "It should create a new user Properly" do
    bank = Bank.create(name:"Coolest bank")
    bank.save
    reward_manager = RewardManager.create
    reward_manager.save
    puts "Reward Id #{reward_manager.id}"
    assert reward_manager.valid?

    user = User.create(username:"pepesrz", password: "SuperSafe", bank_id: bank.id, reward_manager: reward_manager.id)
    user.save
    assert user.valid?
  end
end
