class UserEventsController < ApplicationController
  before_action :authorized
  def event_handler
    puts @user
    render json: {data: {message:"Event handled correctly"}}, status: :ok
  end
end
