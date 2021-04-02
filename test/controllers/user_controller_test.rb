require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  test 'It should return 402 when trying to log in' do
    params = { username: 'pepe', password: 'worngpass'}
    post login_url, params: params
    assert_response :unauthorized
  end
end
