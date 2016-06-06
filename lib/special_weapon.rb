require_relative 'Item'
require_relative 'Weapon'
require_relative 'Grenade'
require_relative 'Robot'

class SpecialWeapon < Grenade

  def initialize
    super
    @name = "Special Weapon"
    @range = 1
    @damage = 30
  end

  def special_hit(robot)
    robot.wound_health(damage)
  end

  def special_hit_surrounding(robot)
    # for each robot in @all_nearby, special_hit(robot_nearby)
    @robots_near_target = robot.scan
    @robots_near_target.each do |robot_nearby|
      special_hit(robot_nearby)
    end
  end

end