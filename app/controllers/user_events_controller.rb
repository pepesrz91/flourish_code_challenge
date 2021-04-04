require 'event_store'

class UserEventsController < ApplicationController
  before_action :authorized

  def event_handler
    return render json: { data: { message: "Wrong Event Type" } }, status: :bad_request unless event_params.key?(:type)

    puts EventStore.user_authenticated
    case event_params[:type]
    when EventStore.user_paid_bill
      puts "User paid bill event"
    when EventStore.user_authenticated
      puts "User Authenticated"
      user_authenticated_event
    when EventStore.user_made_deposit_into_savings_account
      puts "User made deposit"
    else
      return render json: { data: { message: "Invalid event type" } }, status: :bad_request
    end
    render json: { data: { message: "Event handled correctly" } }, status: :ok
  end

  private

  def event_params
    params.permit(:type)
  end

  def user_authenticated_event
    reward_manager = RewardManager.find_by_user_id(@user.id)

    now = Time.now.utc
    start_yesterday = 1.day.ago
    end_yesterday = Date.yesterday.end_of_day
    start_today = Date.today.beginning_of_day
    end_today = Date.today.end_of_day

    login_yesterday = SessionStore.where(last_login: start_yesterday..end_yesterday, user_id: @user.id)
    login_today = SessionStore.where(last_login: start_today...end_today, user_id: @user.id)

    if login_yesterday.records.empty? && login_today.records.empty?
      reward_manager.login_streak = 1
      reward_manager.save
      SessionStore.upsert({ user_id: @user.id, last_login: now, created_at: now, updated_at: now })
    elsif login_today.empty? && !login_yesterday.empty?
      if reward_manager.login_streak == 6
        reward_manager.points += 1000
        reward_manager.login_streak = 0
      else
        reward_manager.login_streak += 1;
      end
      reward_manager.save
    else
      return
    end
  end
end
