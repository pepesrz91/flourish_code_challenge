class ApiFake

  attr_accessor :above_100, :below_100

  def initialize
    super
    @below_100 = [
      {
        type: "SAVINGS_ACCOUNT",
        balance: 59
      },
      {
        type: "PORTFOLIO",
        balance: 100_000
      },
      {
        type: "CREDIT",
        amount: 3_000
      }
    ]

    @above_100 = [
      {
        type: "SAVINGS_ACCOUNT",
        balance: 100
      },
      {
        type: "PORTFOLIO",
        balance: 100_000
      },
      {
        type: "CREDIT",
        amount: 3_000
      }
    ]

  end

  def query(user_id)
    if user_id.even?
      @above_100
    else
      @below_100
    end
  end
end