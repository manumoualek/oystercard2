require_relative "./journey"

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
    @journey.exit(station, zone)
    deduct(@journey.charge)
    log_and_clear
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

  def log_and_clear
    @journey.add_journey
    @journey.clear_exit
    @journey.clear_entry
  end

  def journey_printer
    print(@journey.return_log)
  end
  private
  def deduct(cost)
    @balance -= cost 
  end  
end
