class EventStore
  # ...
  @@user_authenticated = 'UserAuthenticated'
  @@user_paid_bill = 'UserPaidBill'
  @@user_made_deposit_into_savings_account = 'USerMadeDepositIntoSavingsAccount'

  mattr_accessor :user_authenticated, :user_paid_bill, :user_made_deposit_into_savings_account

  def self.get_event_session(start_date, end_date, user_id)
    SessionStore.where(last_login: start_date..end_date, user_id: user_id)
  end

  def self.user_authenticated_event(user_id, yesterday_login, today_login)
    reward_manager = RewardManager.find_by_user_id(user_id)
    now = Time.now.utc
    if yesterday_login.records.empty? && today_login.records.empty?
      reward_manager.login_streak = 1
      reward_manager.save
      SessionStore.update({ user_id: user_id, last_login: now, created_at: now, updated_at: now })
    elsif yesterday_login.empty? && !today_login.empty?
      if reward_manager.login_streak == 6
        reward_manager.points += PointStore.seven_day_strike
        reward_manager.login_streak = 0
      else
        reward_manager.login_streak += 1
      end
      reward_manager.save
    end
    { reward_manager: reward_manager, message: "UserAuthenticated event handled successfully" }
  end

  def self.user_paid_bill_event(user_id, amount)
    reward_manager = RewardManager.find_by_user_id(user_id)
    point_store = PointStore.new
    if !(amount.is_a? Float) || amount < 10
      { reward_manager: reward_manager, message: "Amount not enough" }
    else
      operator = amount / 10
      reward_manager.points += operator * point_store.paid_bill_points
      reward_manager.save
      { reward_manager: reward_manager, message: "UserPaidBill event processed correctly" }
    end
  end

end

