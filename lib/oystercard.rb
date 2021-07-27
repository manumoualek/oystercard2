class Oystercard
  attr_reader :balance, :station
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize(balance: 0, station: nil)
    @balance = balance
    @station = station
  end
  
  def top_up(amount)
    fail "Can't top up, would take balance over #{MAX_BALANCE}" if max_balance?(amount)
      @balance += amount
  end  

  def deduct(cost)
    @balance -= cost
  end  

  def touch_in(station)
    fail "Can't touch in, balance under #{MIN_CHARGE}" if min_balance?
    @station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @station = nil
  end

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end
  
  def min_balance?
    @balance < MIN_CHARGE
  end
  
  def in_journey?
    @station != nil
  end  

end  