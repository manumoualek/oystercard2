require "journey_log"
require "station"

describe JourneyLog do
  describe "#add_journey" do
    it "should add a journey to the log" do
      subject = JourneyLog.new
      subject.add_journey(Station.new("Test Station", 1),Station.new("Test Exit Station", 2),2)
      expect(subject.log[0][:entry_station].station_array[0]).to eq "Test Station"
    end
  end

  describe "#return_log" do
    it "returns the log of journeys" do
      journey1 = JourneyLog.new
      journey1.add_journey(Station.new("Test Station", 1),Station.new("Test Exit Station", 2),2)
      expect(journey1.return_log).to eq "ENTRY: Station: Test Station :: Zone: 1\nEXIT: Station: Test Exit Station :: Zone: 2\nCHARGE:2\n\n"
    end
  end
end