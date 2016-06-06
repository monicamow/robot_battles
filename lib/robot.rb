class Robot

  # class variable to store instances of robots
  @@all_robots = Array.new

  attr_reader :position, :items, :health, :hitpoints, :equipped_weapon, :shield_points, :all_nearby
  attr_writer :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    #@items_weight = 0
    @health = 100
    @hitpoints = 5
    @shield_points = 50
    # add robot to class variable each time one is instantiated
    @@all_robots << self
  end

  # class method to manage instances of robots
  def self.robot_list
    @@all_robots
  end

  # class method return all robots in position (x,y)
  def self.in_position(x, y)
    @@all_robots.select do |robot| 
      robot.position == [x, y]
    end
  end

  # instance methods
  def move_left
    position[0] -= 1
  end

  def move_right
    position[0] += 1
  end

  def move_up
    position[1] += 1
  end

  def move_down
    position[1] -= 1
  end

  def pick_up(item)
    # auto feed BoxOfBolts when picked up and health 80 or less
    if item.is_a?(BoxOfBolts) && health <= 80
      item.feed(self)
    end

    # auto recharge shield_points when Battery picked up and shield_points battery < 50
    if item.is_a?(Battery) && shield_points < 50
      recharge
    end

    # auto pick up item if weapon
    if item.is_a? Weapon
      @equipped_weapon = item
    end

    if can_pick_up?(item)
      items << item
      true
    else
      false
    end
  end

  def can_pick_up?(item)
    (item.weight + items_weight <= 250)
  end

  def items_weight
    items.reduce(0) { |sum, item| sum + item.weight }
  end

  # def wound(amount)
  #   @shield_points -= amount if shield_points > 0

  #   if shield_points < 0
  #     @health_allocation = -shield_points
  #   else
  #     @health_allocation = 0
  #   end

  #   @shield_points = 0 if shield_points < 0

  #   # deduction from health after shield_points deduction
  #   @health -= @health_allocation
  #   @health = 0 if health < 0
  # end

  def wound_shield(amount)
    @shield_points -= amount if shield_points > 0

    if shield_points < 0
      @health_allocation = -shield_points
    else
      @health_allocation = 0
    end

    @shield_points = 0 if shield_points < 0

    # deduction from health after shield_points deduction
    @health -= @health_allocation
    @health = 0 if health < 0   
  end

  def wound_health(amount)
    @health -= amount
    @health = 0 if health < 0 
    @shield_points = 0   
  end

  def heal(amount)
    @health += amount
    @health = 100 if health > 100
  end

  # ENHANCEMENT 1
  def heal!(amount)
    raise RobotAlreadyDeadError if health <= 0
    heal(amount)
  end

  def can_attack?(other_robot)
    (self.position[0] == other_robot.position[0] + 1) || 
    (self.position[1] == other_robot.position[1] + 1) || 
    (self.position[0] == other_robot.position[0] - 1) || 
    (self.position[1] == other_robot.position[1] - 1) || 
    (self.position == other_robot.position) || 
    @equipped_weapon.is_a?(Grenade) && (
    (self.position[0] == other_robot.position[0] + 2) || 
    (self.position[1] == other_robot.position[1] + 2) || 
    (self.position[0] == other_robot.position[0] - 2) || 
    (self.position[1] == other_robot.position[1] - 2)
    )

  end

  def attack(other_robot)
    if can_attack?(other_robot)
      # switch this statement with the else statement to attack all near robots
      case 
      when @equipped_weapon.nil? == true
        other_robot.wound_shield(hitpoints)
      when @equipped_weapon.is_a?(SpecialWeapon) == true
        @equipped_weapon.special_hit(other_robot)
        @equipped_weapon.special_hit_surrounding(other_robot)
      else
        @equipped_weapon.hit(other_robot)
      end
    end
    @equipped_weapon = nil if @equipped_weapon.is_a? Grenade
  end

  # ENHANCEMENT 2
  def attack!(other_robot)
    raise EnemyNotAttackable unless other_robot.is_a? Robot
    attack(other_robot)
  end

  def recharge
    @shield_points = 50
  end

  def scan

    @right = (self.position[0] + 1).to_i
    @left = (self.position[0] - 1).to_i
    @up = (self.position[1] + 1).to_i
    @down = (self.position[1] - 1).to_i

    @right = Robot.in_position(@right, 0)
    @left = Robot.in_position(@left, 0)
    @up = Robot.in_position(0, @up)
    @down = Robot.in_position(0, @down)

    @all_nearby = [@right, @left, @up, @down].flatten # FLATTEN THIS
    # # do an each loop over each position
    # return @nearby_count = @right.count + @left.count + @up.count + @down.count

  end

  #def scan_right
  #def scan_left
  #def scan_up
  #def scan_down

  # clear cache of all robots for testing purposes
  def self.clear_all_robots
    @@all_robots.clear
  end

end


