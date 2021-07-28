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
    
    before(:each) do  
    @subject = Oystercard.new(:balance => 1 )  
    @subject.touch_in("Test Station", 1)
    end

    it 'states whether the user has "touched in" or not.' do
      expect(@subject.in_journey?).to eql true
    end  

    it 'allows the user to "touch_in" if there is at least enough to cover minimum charge' do
      @subject = Oystercard.new(:balance => 0.5)
      expect { @subject.touch_in("Test Station", 1) }.to raise_error("Can't touch in, balance under #{Oystercard::MIN_CHARGE}")
    end
    

    it "it returns a station name, not nil" do
      expect(@subject.journey.entry_station).to_not eql nil
    end  

    # station_dbl = double("station", :name => "Oxford Road")
    # subject = Oystercard.new(:station => station_dbl)
  end
  
  describe "#touch_out" do 
    
    before(:each) do
      @subject = Oystercard.new(:balance => 10)
      # @subject.touch_in()
      # @subject.touch_out("Test Exit Station", 2)
    end

    it "charges minimum fare at touch out" do
      @subject.touch_in("Test Station",1)
      expect { @subject.touch_out("Exit Station", 2)}.to change {@subject.balance}.by -Oystercard::MIN_CHARGE
    end
    
    it 'states whether the user has "touched out" or not.' do 
      expect(@subject.in_journey?).to eql false
    end

    # it "returns the correct entry and exit stations" do
    #   expect([@subject.journeys[0][:entry_station].printer,@subject.journeys[0][:exit_station].printer]).to eql [["Test Station",1], ["Test Exit Station", 2]]  
    # end  

    it "returns an error if no initial touch in " do
      subject = Oystercard.new()
      expect{subject.touch_out("New Exit Station", 2)}.to raise_error "You did not touch in"
    end
  end 
end