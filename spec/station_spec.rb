require_relative "../lib/station.rb"

describe Station do
  describe "station" do
    it "should return the station when station is called" do
      station = Station.new("Oxford Road", 1)
      expect(station.station).to(eq("Oxford Road"))
    end
  end
  describe "zone" do
    it "should return the zone when the zone is called" do
      station = Station.new("Oxford Road", 1)
      expect(station.zone).to(eq(1))
    end
  end
end