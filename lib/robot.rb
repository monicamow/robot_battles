class Robot

  attr_reader :position, :items, :health, :hitpoints, :equipped_weapon
  attr_writer :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    #@items_weight = 0
    @health = 100
    @hitpoints = 5
  end

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

  # fix 03
  def pick_up(item)
    if item.is_a?(BoxOfBolts) && health <= 80
      item.feed(self)
    end
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

  # 04

  def wound(amount)
    @health -= amount
    @health = 0 if health < 0
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
      unless @equipped_weapon.nil?
        @equipped_weapon.hit(other_robot)
      else
        other_robot.wound(hitpoints)
      end
    end
    @equipped_weapon = nil if @equipped_weapon.is_a? Grenade
  end

  # ENHANCEMENT 2
  def attack!(other_robot)
    raise EnemyNotAttackable unless other_robot.is_a? Robot
    attack(other_robot)
  end
end
