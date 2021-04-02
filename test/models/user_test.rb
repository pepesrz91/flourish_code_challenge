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
end
