require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "It should create a user properly" do
    bank = Bank.create(name:"coolest bank")
    bank.save
  end
end
