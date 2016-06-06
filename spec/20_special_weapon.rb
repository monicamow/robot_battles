require 'spec_helper'

# SpecialWeapon
# - Grenade
# range of 1
# target-specific
# damages all robots surrounding target
# damage goes through shield
# reduces health by 30 (assume target loses health 30 as well)

describe SpecialWeapon do 

  before :each do

    # CLEAR CACHE OF ROBOTS FROM TESTS 1-19
    Robot.clear_all_robots
    @grenade = Grenade.new
    @specialweapon = SpecialWeapon.new

    @bob = Robot.new # self
    @enemy = Robot.new # enemy

    # ROBOTS SURROUNDING ENEMY, @enemy
    @tina = Robot.new # right of enemy #1
    @tina.move_right

    @john = Robot.new # left of enemy
    @john.move_left

    @ruby = Robot.new # above enemy
    @ruby.move_up

    @jake = Robot.new # below enemy
    @jake.move_down

    @coco = Robot.new # right of enemy #2
    @coco.move_right
  end

  it 'should be a Grenade with range 1, damage 30, and weight 40' do
    expect(@specialweapon).to be_a(Grenade)
    expect(@specialweapon.range).to eq(1)
    expect(@specialweapon.damage).to eq(30)
    expect(@specialweapon.weight).to eq(40)
  end

  describe '#attack' do

    it 'enemy health -= 30 and shield_points = 0 from SpecialWeapon attack' do
        @bob.pick_up(@specialweapon)      
        expect(@bob.equipped_weapon).to eq(@specialweapon)

        @bob.attack(@enemy)
        expect(@enemy.shield_points).to eq(0)
        expect(@enemy.health).to eq(70)
    end    

    it 'enemy health/shield_points should respond normally to Grenade attack' do
      @bob.pick_up(@grenade)
      expect(@bob.equipped_weapon).to eq(@grenade)

      @bob.attack(@enemy)
      expect(@enemy.shield_points).to eq(35)
      expect(@enemy.health).to eq(100)      
    end

    it "robots nearby health -= 30 and shield_points = 0" do
      @bob.pick_up(@specialweapon)      
      expect(@bob.equipped_weapon).to eq(@specialweapon)

      @bob.attack(@enemy)

      expect(@tina.shield_points).to eq(0)
      expect(@tina.health).to eq(70)

      expect(@john.shield_points).to eq(0)
      expect(@john.health).to eq(70)

      expect(@ruby.shield_points).to eq(0)
      expect(@ruby.health).to eq(70)

      expect(@jake.shield_points).to eq(0)
      expect(@jake.health).to eq(70)

      expect(@coco.shield_points).to eq(0)
      expect(@coco.health).to eq(70)
    end

  end

end




