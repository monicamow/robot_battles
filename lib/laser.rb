class Laser < Weapon

  attr_reader :range

  def initialize
    @name = "Laser"
    @weight = 125
    @damage = 25
    @range = 1
  end

end