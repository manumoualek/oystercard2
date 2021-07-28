class Journey
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
    (@entry_station.zone - @exit_station.zone).abs
  end  

  def add_journey
    @log.append({:entry_station => @entry_station, :exit_station => @exit_station, :charge => charge})
  end
  
  def return_log
    return_string = ""
    (0...@log.length).each do |i|
      return_string += "#{[@log[i][:entry_station].printer,
        @log[i][:exit_station].printer,
        @log[i][:charge]]}\n"
    end
    return_string   
  end

end  