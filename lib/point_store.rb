class PointStore
  # ...
  attr_accessor :seven_day_strike, :paid_bill_points, :deposit_badges

  def initialize
    super
    @seven_day_strike = 200
    @paid_bill_points = 50
    @deposit_badges = [
      {
        name: "deposit_badge_1",
        balance_rule: 100,
        deposit_rule: 1,
        reward: 1000
      }
    ]
  end

  def self.seven_day_strike
    200
  end
end