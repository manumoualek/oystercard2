class Journey

  PENALTY = 6
  attr_reader :entry_station, :exit_station, :log

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @log = []
  end
  
  def entry(station, zone)
    @entry_station = Station.new(station, zone)
  end  

  def exit(station, zone)
    @exit_station = Station.new(station, zone)
  end  

  def charge
    if @entry_station == nil || @exit_station == nil
      return PENALTY
    else
      return (@entry_station.zone - @exit_station.zone).abs
    end
    
  end  

  def add_journey
    @log.append({:entry_station => @entry_station, :exit_station => @exit_station, :charge => charge})
  end
  
  def return_log
    return_string = ""
    (0...@log.length).each do |i|
      return_string += "ENTRY: #{pprinter(@log[i][:entry_station].station_array)} EXIT: #{pprinter(@log[i][:exit_station].station_array)} CHARGE:#{@log[i][:charge]}\n"
      #return_string += "|  #{pprinter(@log[i][:entry_station].station_array)}  |  #{pprinter(@log[i][:exit_station].station_array)}  |  Charge: #{@log[i][:charge]}  |\n,"
    end
    return_string   
  end

  def pprinter(station)
    #PRETTTIFY <3
    "Station: #{station[0]} :: Zone: #{station[1]}"
  end

  def clear_entry
    @entry_station = nil
  end

  def clear_exit
    @exit_station = nil
  end
end  