require_relative 'car.rb'
require_relative 'truck.rb'
require_relative 'sport_car.rb'

truck = Truck.new
puts truck.inspect
truck.start_engine
puts truck.inspect
puts "Truck RPM: #{truck.current_rpm}"


car = Car.new
puts car.inspect
car.start_engine
puts car.inspect
puts "Car RPM: #{car.current_rpm}"


sport = SportCar.new
puts sport.inspect
sport.start_engine
puts sport.inspect
puts "Sport Car RPM: #{sport.current_rpm}"



