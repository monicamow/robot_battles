require_relative 'spec_helper'

describe Robot do 

  before :each do
    @robot = Robot.new
  end

  describe '#heal!' do

    it 'should raise a RobotAlreadyDeadError if health <= 0' do
      #expect { raise RobotAlreadyDeadError }.to raise_error
      @robot.wound(200) # make big wound b/c shield_points
      expect(@robot.health).to eq(0)
      expect{ @robot.heal!(100) }.to raise_error(RobotAlreadyDeadError)
    end
  end

  describe '#attack!' do

    it 'should raise a EnemyNotAttackable if robot tries to attack non-robot <= 0' do
      #expect { raise EnemyNotAttackable }.to raise_error
      bread = Item.new("bread", 1)
      expect{ @robot.attack!(bread) }.to raise_error(EnemyNotAttackable)
    end
  end

end