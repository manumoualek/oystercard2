require "station"
require "journey"

class Oystercard
  attr_reader :balance, :journey
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize(balance: 0, journey: Journey.new)
    @balance = balance
    @journey = journey
  end
  
  def top_up(amount)
    fail "Can't top up, would take balance over #{MAX_BALANCE}" if max_balance?(amount)
      @balance += amount
  end  

  def deduct(cost)
    @balance -= cost 
  end  

  def touch_in(station, zone)
    fail "Can't touch in, balance under #{MIN_CHARGE}" if min_balance?
    if in_journey?
      @journey.charge
      @journey.clear_entry
      touch_in(station, zone)
    else
      @journey.entry(station, zone)
    end
  end

  def touch_out(station, zone)
    fail "You did not touch in" unless in_journey?
     # NEEDS REINTERGRATING
    @journey.exit(station, zone)
    deduct(@journey.charge)
    @journey.add_journey
    @journey.clear_entry
    @journey.clear_exit
  end

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end
  
  def min_balance?
    @balance < MIN_CHARGE
  end
  
  def in_journey?
    @journey.entry_station != nil
  end   
end  