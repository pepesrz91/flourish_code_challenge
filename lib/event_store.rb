
class EventStore
  # ...
  @@user_authenticated = 'UserAuthenticated'
  @@user_paid_bill = 'UserPaidBill'
  @@user_made_deposit_into_savings_account = 'USerMadeDepositIntoSavingsAccount'

  mattr_accessor :user_authenticated, :user_paid_bill, :user_made_deposit_into_savings_account

  def self.get_event_session(start_date, end_date, user_id)
    SessionStore.where(last_login: start_date..end_date, user_id: user_id)
  end
end

