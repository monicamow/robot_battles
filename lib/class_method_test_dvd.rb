class DVD
  @@array = Array.new
  attr_accessor :title, :category, :runTime, :year, :price 

  def self.all_instances
    @@array
  end

  def initialize()
    @title = title
    @category = category
    @runTime = runTime
    @year = year
    @price = price
    @@array << self
  end
end

DVD.new
p DVD.all_instances