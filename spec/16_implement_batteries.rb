require 'spec_helper'

describe Robot do 

  before :each do
    @robot = Robot.new
  end

  describe '#recharge' do
  # when shield_points less that 50, and pick up Battery, 
  # recharge shield_points back to 50
    it 'should recharge shield_points back to 50 battery life' do
      @battery = Battery.new

      @robot.pick_up(@battery)      
      expect(@robot.items).to include(@battery)

      expect(@robot.shield_points).to eq(50)
    end
  end
end