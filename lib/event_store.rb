
class EventConstants
  # ...
  @@user_authenticated = 'UserAuthenticated'
  @@user_paid_bill = 'UserPaidBill'
  @@user_made_deposit_into_savings_account = 'USerMadeDepositIntoSavingsAccount'

  mattr_accessor :user_authenticated, :user_paid_bill, :user_made_deposit_into_savings_account

end

