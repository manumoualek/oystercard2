require_relative "../lib/journey.rb"
describe Journey do
  describe "#entry" do
    
    before(:each)do
      @subject = Journey.new
    end

    it "stores the entry station" do
      @subject.entry("Test Station", 1)
      expect(@subject.entry_station.printer).to eql ["Test Station", 1]
    end
  end
  
  describe "#exit" do

    before(:each)do
      @subject = Journey.new
      @subject.entry("Test Station", 1)
    end

    it "stores the exit station" do
      @subject.exit("Test Exit Station", 2)
      expect(@subject.exit_station.printer).to eql ["Test Exit Station", 2]
    end
  end

  describe "#charge" do
    before(:each) do
      entry_dbl = double("Entry Station",:zone => 1)
      exit_dbl = double("Exit Station",:zone => 2)
      @subject = Journey.new(:entry_station => entry_dbl, :exit_station => exit_dbl)
    end
    
    it "returns the value of the charge" do
      expect(@subject.charge).to eql 1
    end  
  end

  describe "#add_journey" do
    before(:each) do
      @subject = Journey.new(
        :entry_station => Station.new("Test Station", 1),
        :exit_station => Station.new("Test Exit Station", 2)
      )
    end
    
    it "logs the completed journey" do
      @subject.add_journey
      expect(
        [@subject.log[0][:entry_station].printer,
         @subject.log[0][:exit_station].printer,
         @subject.log[0][:charge]]).to eql [["Test Station",1], ["Test Exit Station", 2], 1]
    end  

  end

  describe "#return_log" do
    before(:each) do
      @subject = Journey.new(
        :entry_station => Station.new("Test Station", 1),
        :exit_station => Station.new("Test Exit Station", 2)
      )
      @subject.add_journey
    end

    it "returns a readable log of journeys" do
      expect(@subject.return_log).to eql '[["Test Station", 1], ["Test Exit Station", 2], 1]' + "\n"  

    end  
  end
end  