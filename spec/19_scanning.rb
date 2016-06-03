require 'spec_helper'

# the #scan instance method should be similar to the #in_position class method

describe Robot do 

  before :each do

    # CLEAR CACHE OF ROBOTS FROM TESTS 1-18
    Robot.clear_all_robots

    @bob = Robot.new # self

    @tina = Robot.new # right robot 1
    @tina.move_right

    @john = Robot.new # left robot
    @john.move_left

    @ruby = Robot.new # above robot
    @ruby.move_up

    @jake = Robot.new # below robot
    @jake.move_down

    @coco = Robot.new # right robot 2
    @coco.move_right
  end

  describe '#scan' do

    it 'should return a list of robots that are next to the robot' do
      expect(@bob.scan).to eq(5)
    end

  end

end




