class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'Bearer')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'Bearer', true, algorithm: 'HS256')

      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged?
    !!logged_user
  end

  def authorized
    render json: {message:'Please log in'}, status: :unauthorized unless logged?
  end
end
