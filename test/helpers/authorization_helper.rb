module AuthorizationHelper

  def login_helper(user)
    post '/login',
         params: { username: user[:username], password: user[:password] },
         as: :json
    # The three categories below are the ones you need as authentication headers.

    puts "Here", JSON.parse(response.body)
    JSON.parse(response.body)
  end
end