class PointStore
  # ...
  attr_accessor :seven_day_strike, :paid_bill_points

  def initialize
    super
    @seven_day_strike = 200
    @paid_bill_points = 50
  end
  def self.seven_day_strike
    200
  end
end