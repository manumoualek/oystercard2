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

  def printer
    [@station,@zone]
  end  
end  
