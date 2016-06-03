require 'spec_helper'


describe Robot do 

  before :each do

    # CLEAR CACHE OF ROBOTS FROM TESTS 1-17
    Robot.clear_all_robots
      
    @bob_the_robot = Robot.new
    @bob_the_robot.move_up

    @john_the_robot = Robot.new
    @john_the_robot.move_up

    @tina_the_robot = Robot.new
  end

  describe '#self.in_position' do

    it 'should return a list of robots that are in position (x, y)' do
      expect(Robot.in_position(0, 1).length).to eq(2)
      expect(Robot.robot_list).to include(@bob_the_robot)
      expect(Robot.robot_list).to include(@john_the_robot)
    end

  end

end