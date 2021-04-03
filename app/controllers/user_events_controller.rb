class UserEventsController < ApplicationController
  before_action :authorized

  def event_handler

    return render json: { data: { message: "Wrong Event Type" } }, status: :bad_request unless event_params.key?(:type)

    case event_params[:type]
    when EventConstants.user_paid_bill
      put "User paid bill event"
    when EventConstants.user_authenticated
      put "User Authenticated"
    when EventConstants.user_made_deposit_into_savings_account
      put "User made deposit"
    else
      return render json: {data: {message: "Invalid event type"}}, status: :bad_request
    end
    puts @user
    render json: { data: { message: "Event handled correctly" } }, status: :ok
  end

  private

  def event_params
    params.permit(:type)
  end
end
