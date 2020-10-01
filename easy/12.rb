# наследование классов
class Transport
  attr_accessor :color, :wheels

  def sayBipBip
    puts "Bip Bip"
  end
end

class Cars < Transport
  attr_accessor :isMechanic

  def sayBipBip
    puts 'BUms'
    super

  end
end

class Moto < Transport

end


bmw = Cars.new
audi = Cars.new

bmw.sayBipBip
audi.sayBipBip

bmw.inspect