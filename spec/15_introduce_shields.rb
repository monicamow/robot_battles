require 'spec_helper'

describe Robot do 

  before :each do
    @robot = Robot.new
  end

  # robots have 50 shield points 
  it 'should have 50 shield_points to start' do
    expect(@robot.shield_points).to eq(50)
  end

  describe '#wound' do
    #@laser = Laser.new
    it 'should drain shield_points before health' do
      expect(@robot).to receive(:wound).and_return(20)
    end

  end
  # when robot damaged it first drains the shield and then actual health

end