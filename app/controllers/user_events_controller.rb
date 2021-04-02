class UserEventsController < ApplicationController
  before_action :authorized
  def event_handler
    puts @user
  end
end
