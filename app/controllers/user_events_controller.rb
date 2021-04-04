require 'event_store'
require 'point_store'

class UserEventsController < ApplicationController
  before_action :authorized

  def event_handler
    return render json: { data: { message: "Wrong Event Type" } }, status: :bad_request unless event_params.key?(:type)

    puts EventStore.user_authenticated
    case event_params[:type]
    when EventStore.user_paid_bill
    when EventStore.user_authenticated
      user_authenticated
    when EventStore.user_made_deposit_into_savings_account

    else
      return render json: { data: { message: "Invalid event type" } }, status: :bad_request
    end
    render json: { data: { message: "Event handled correctly" } }, status: :ok
  end

  private

  def event_params
    params.permit(:type, :timestamp)
  end

  def user_authenticated
    login_yesterday = EventStore.get_event_session(1.day.ago, Date.yesterday.end_of_day, @user.id)
    login_today = EventStore.get_event_session(Date.today.beginning_of_day, Date.today.end_of_day, @user.id)

    result = EventStore.user_authenticated_event(@user.id, login_yesterday, login_today)
    end
end
