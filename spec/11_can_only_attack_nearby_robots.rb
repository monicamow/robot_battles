require_relative 'spec_helper'

# Robots can only attack enemy robots that are in the tile/block next to them
# So if an enemy robot is directly above, below, or next to the robot, then it will wound the enemy robot
# Otherwise the attack method should not do anything

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe '#attack' do
    # 1 UP
    context "with enemy robot directly above" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_up
      end

      it "is able to successfully wound the enemy" do
        expect(@robot2).to receive(:wound_shield)
        #byebug
        @robot.attack(@robot2)
      end
    end

    # 2 UP
    context "with enemy robot two blocks above" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_up
        @robot2.move_up # a second time
      end

      it "is unable to successfully wound the enemy" do
        expect(@robot2).not_to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 1 DOWN
    context "with enemy robot one block below" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_down
      end

      it "is able to successfully wound the enemy" do
        expect(@robot2).to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 2 DOWN
    context "with enemy robot two blocks below" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_down
        @robot2.move_down
      end

      it "is unable to successfully wound the enemy" do
        expect(@robot2).not_to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 1 LEFT
    context "with enemy robot one block left" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_left
      end

      it "is able to successfully wound the enemy" do
        expect(@robot2).to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 2 LEFT
    context "with enemy robot two blocks left" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_left
        @robot2.move_left
      end

      it "is unable to successfully wound the enemy" do
        expect(@robot2).not_to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 1 RIGHT
    context "with enemy robot one block right" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_right
      end

      it "is able to successfully wound the enemy" do
        expect(@robot2).to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end

    # 2 DOWN
    context "with enemy robot two blocks right" do
      before(:each) do
        @robot2 = Robot.new
        @robot2.move_right
        @robot2.move_right
      end

      it "is unable to successfully wound the enemy" do
        expect(@robot2).not_to receive(:wound_shield)
        @robot.attack(@robot2)
      end
    end
  end
end
