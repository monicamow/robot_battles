class Grenade < Weapon

  attr_reader :range
  
  def initialize
    @name = "Grenade"
    @weight = 40
    @damage = 15
    @range = 2
  end

end