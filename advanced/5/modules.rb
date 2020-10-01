# пространтсва имен
module Admin
  class Car
    def add
      puts('fff')
    end
  end

end




car = Admin::Car.new
car.add
puts car.inspect
