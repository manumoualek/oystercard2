class JourneyLog
  attr_reader :log
  def initialize(log: [])
    @log = log
  end  

  def add_journey(entry_station,exit_station,charge)
    @log.append({:entry_station => entry_station, :exit_station => exit_station, :charge => charge})  
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
end  