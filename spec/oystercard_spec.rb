require_relative "../lib/oystercard.rb"

describe Oystercard do
  
  describe "#initialize" do
    it "initalizes with a balance of 0" do
      expect(subject.balance).to eql 0
    end
  end

  describe "#top_up" do
    it "tops up card with amount requested/passed in as argument" do
      expect {subject.top_up 5 }.to change {subject.balance}.by 5
    end

    it "throws an error when top up takes balance over max balance" do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect{subject.top_up(1)}.to raise_error("Can't top up, would take balance over #{Oystercard::MAX_BALANCE}")
    end  
  end

 


  describe "#deduct" do 
    it 'deducts value spent from the balance' do 
      expect { subject.deduct 10 }.to change {subject.balance}.by -10
    end
  end

  describe "#touch_in" do
    
    before do
    subject.top_up(1)
    subject.touch_in("Test Station")
    end

    it 'states whether the user has "touched in" or not.' do
      expect(subject.in_journey?).to eql true
    end  

    it 'allows the user to "touch_in" if there is at least minimum balance' do
      subject = Oystercard.new(:balance => 0.5)
      expect{subject.touch_in("Test Station")}.to raise_error("Can't touch in, balance under #{Oystercard::MIN_CHARGE}")
    end
    

    it "it returns a station name" do
      expect(subject.station).not_to eql nil
    end  

    # station_dbl = double("station", :name => "Oxford Road")
    # subject = Oystercard.new(:station => station_dbl)
  end

  describe "#touch_out" do 

    before(:each) do
      @subject = Oystercard.new(:station => "Test Station", :balance => 10)
      @subject.touch_out("Test Exit Station")
    end

    it 'states whether the user has "touched out" or not.' do 
      expect(@subject.in_journey?).to eql false
    end

    it "returns the station at touch-out" do 
      expect(@subject.station).to eql nil
    end

    it "returns the correct entry and exit stations" do
      # subject = Oystercard.new(:station => "Test Station")
      # subject.touch_out("Test Exit Station")
      expect([@subject.journeys[0][:entry_station],@subject.journeys[0][:exit_station]]).to eql ["Test Station", "Test Exit Station"]  
    end  

    it "adds all journeys the array" do
      # subject.top_up(10)
      # subject = Oystercard.new
      # subject.touch_out("Test Exit Station")
      # @subject.top_up(5)
      @subject.touch_in("New Entry Station")
      @subject.touch_out("New Exit Station")
      expect(@subject.journeys.length).to eql 2
    end  


  end 


  it "returns the station value of nil" do
    expect(subject.station).to eql nil
  end

  it 'states if the user is "in journey" or not. ' do  
    expect([true, false]).to include subject.in_journey?
  end

  it "charges minimum fare at touch out" do
    subject.top_up(1)
    expect { subject.touch_out("Exit Station")}.to change {subject.balance}.by -1
  end

  it "journey initializes as an empty array" do
    expect(subject.journeys).to eql []
  end

end