class Car

  def initialize(speed=0, engine_volume=1.6)
    @speed =speed
    @engine_volume = engine_volume
  end

  def start_engine
    puts "дРынн!"
  end

  def beep
    puts "Биби"
  end

  def stop
    puts "stop"
    @speed =  0
  end

  def go
    @speed = 50
  end

  def current_speed
    @speed
  end

  def engine_volume
    @engine_volume
  end

  def set_speed(speed)
    @speed = speed
  end
end

car = Car.new
puts car.inspect
puts car.current_speed
puts car.engine_volume
car.set_speed(20)
puts car.current_speed

