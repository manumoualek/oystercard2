class Station

  def initialize(station, zone)
    @station = station
    @zone = zone
  end
  
  def station
    @station
  end
  
  def zone
    @zone
  end  

  def station_array
    [@station,@zone]
  end  
end  
