class Oystercard
  attr_reader :balance, :station, :journeys
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize(balance: 0, station: nil, journeys: Array.new)
    @balance = balance
    @station = station
    @journeys = journeys
  end
  
  def top_up(amount)
    fail "Can't top up, would take balance over #{MAX_BALANCE}" if max_balance?(amount)
      @balance += amount
  end  

  def deduct(cost)
    @balance -= cost
  end  

  def touch_in(station, zone)
    fail "You did not touch out last journey" if in_journey?
    fail "Can't touch in, balance under #{MIN_CHARGE}" if min_balance?
    @station = Station.new(station,zone)
  end

  def touch_out(exit_station, zone)
    fail "You did not touch in" unless in_journey?
    deduct(MIN_CHARGE)
    @journeys.append({:entry_station => @station, :exit_station => Station.new(exit_station,zone)})
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