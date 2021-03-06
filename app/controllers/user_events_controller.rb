require 'event_store'
require 'point_store'
require './lib/api_fake'

class UserEventsController < ApplicationController
  before_action :authorized

  # EVENT HANDLER, RECEIVES EVENT TYPES AND CORRESPONDING DATA
  def event_handler
    unless event_params.key?(:type)
      return render json: { data: { message: "Event type cannot be empty" } },
                    status: :bad_request
    end

    case event_params[:type]
    when EventStore.user_paid_bill
      data = user_paid_bill
    when EventStore.user_authenticated
      data = user_authenticated
    when EventStore.user_made_deposit_into_savings_account
      data = user_made_deposit_savings
    else
      return render json: { data: { message: "Invalid event type" }, type: event_params[:type] }, status: :bad_request
    end
    render json: { data: data }, status: :ok
  end

  private

  def event_params
    params.permit(:type, :amount)
  end

  # USER AUTHENTICATED EVENT METHOD
  def user_authenticated
    login_yesterday = EventStore.get_event_session(1.day.ago, Date.yesterday.end_of_day, @user.id)
    login_today = EventStore.get_event_session(Date.today.beginning_of_day, Date.today.end_of_day, @user.id)

    EventStore.user_authenticated_event(@user.id, login_yesterday, login_today)
  end

  # USER PAID BILL EVENT METHOD
  def user_paid_bill
    EventStore.user_paid_bill_event(@user.id, Float(event_params[:amount]))
  end

  # USER MADE DEPOSIT TO SAVINGS ACCOUNT EVENT METHOD
  def user_made_deposit_savings
    EventStore.user_made_deposit_event(@user.id, Float(event_params[:amount]))
  end
end
