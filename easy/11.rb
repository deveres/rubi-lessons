# классы и обьекты



class Car
  attr_accessor :speed, :model, :color

  def initialize(speed, model, color)
    #self.speed = speed
    @speed = speed
    @model = model
    @color = color
  end

  def isSpeedCar
    if @speed>200
      return true
    end
    return false
  end
end

bmw = Car.new(100, 'BMW', 'Black')
audi = Car.new(250, 'Audi', 'White')

puts bmw.inspect.to_s
puts audi.inspect.to_s

puts bmw.isSpeedCar
puts audi.isSpeedCar