require 'spec_helper'

# keep track of all instances of robots using class method

describe Robot do 

  before :each do
    @bob_the_robot = Robot.new
    @john_the_robot = Robot.new
    @tina_the_robot = Robot.new
  end

  describe '#self.robot_list' do

    it 'should list all instances of robots in an array' do
      expect(Robot.robot_list.length).to eq(3)
    end

  end

end