require 'event_store'
require 'point_store'

class UserEventsController < ApplicationController
  before_action :authorized

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
      return render json: { data: { message: "Invalid event type" } }, status: :bad_request
    end
    render json: { data: data }, status: :ok
  end

  private

  def event_params
    params.permit(:type, :amount)
  end

  def user_authenticated
    login_yesterday = EventStore.get_event_session(1.day.ago, Date.yesterday.end_of_day, @user.id)
    login_today = EventStore.get_event_session(Date.today.beginning_of_day, Date.today.end_of_day, @user.id)

    EventStore.user_authenticated_event(@user.id, login_yesterday, login_today)
  end

  def user_paid_bill
    EventStore.user_paid_bill_event(@user.id, Float(event_params[:amount]))
  end

  def user_made_deposit_savings; end
end
