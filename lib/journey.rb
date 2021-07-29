require_relative "./station"


class Journey

  PENALTY = 6
  attr_reader :entry_station, :exit_station, :log

  def initialize(entry_station: nil, exit_station: nil, log: [])
    @entry_station = entry_station
    @exit_station = exit_station
    @log = log
  end
  
  def entry(station, zone)
    @entry_station = Station.new(station, zone)
  end  

  def exit(station, zone)
    @exit_station = Station.new(station, zone)
  end  

  def charge
    if @entry_station == nil || @exit_station == nil
      add_journey
      return PENALTY
    else
      return (@entry_station.zone - @exit_station.zone).abs + 1
    end
    
  end  

  def add_journey
    @log.append({:entry_station => @entry_station, :exit_station => @exit_station, :charge => charge})
  end
  
  def return_log
    return_string = ""
    (0...@log.length).each do |i|
      if @log[i][:entry_station] == nil
        return_string += "ENTRY: #{@log[i][:entry_station]}\nEXIT: #{pprinter(@log[i][:exit_station].station_array)}\nCHARGE:#{@log[i][:charge]}\n\n"
      elsif @log[i][:exit_station] == nil
        return_string += "ENTRY: #{pprinter(@log[i][:entry_station].station_array)}\nEXIT: #{@log[i][:exit_station]}\nCHARGE:#{@log[i][:charge]}\n\n"
      else
        return_string += "ENTRY: #{pprinter(@log[i][:entry_station].station_array)}\nEXIT: #{pprinter(@log[i][:exit_station].station_array)}\nCHARGE:#{@log[i][:charge]}\n\n"
      end
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