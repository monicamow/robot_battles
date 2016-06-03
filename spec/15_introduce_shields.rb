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
    # when robot damaged it first drains the shield and then actual health
    it 'should drain shield_points before health' do
      @robot.wound(20)
      expect(@robot.shield_points).to eq(30)
      expect(@robot.health).to eq(100)
    end
  end

  describe '#attack' do
    # test an actual weapon (PlasmaCannon)
    it 'should take 50 shield_points away and 5 health' do
      @enemy_robot = Robot.new
      @cannon = PlasmaCannon.new

      @robot.pick_up(@cannon)      
      expect(@robot.equipped_weapon).to eq(@cannon)

      @robot.attack(@enemy_robot)
      expect(@enemy_robot.shield_points).to eq(0)
      expect(@enemy_robot.health).to eq(95)
    end
  end

end