require 'spec_helper'

# keep track of all instances of robots using class method

describe Robot do 

  before :each do

    # CLEAR CACHE OF ROBOTS FROM TESTS 1-16
    Robot.clear_all_robots    
    
    @bob_the_robot = Robot.new
    @john_the_robot = Robot.new
    @tina_the_robot = Robot.new
  end

  describe '#self.robot_list' do

    it 'should list all instances of robots in an array' do
      expect(Robot.robot_list.length).to eq(3)
      expect(Robot.robot_list).to include(@bob_the_robot)
      expect(Robot.robot_list).to include(@john_the_robot)
      expect(Robot.robot_list).to include(@tina_the_robot)
    end

  end

end