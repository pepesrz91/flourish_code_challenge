require 'test_helper'
require 'event_store'

class EventStoreTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    test_bank = Bank.create(name: "Coolest Bank")
    test_bank.save
    test_user = User.create(name: "Pepe", username: "pepesrz", password: "SuperSecurePassword", bank_id: test_bank.id)
    test_user.save
    reward_manager = RewardManager.create(points: 0, login_streak: 0, user_id: test_user.id)
    reward_manager.save
  end

  test 'It should not return a session' do
    session = EventStore.get_event_session(Time.now, Date.yesterday, "wrong id")
    assert session.record.empty?
  end
end