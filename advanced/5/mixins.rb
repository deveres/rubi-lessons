# mixin для методов инстанса
module CustomMixin
  def fill_tank(level)
    self.fuel_tank = level
  end

  def fuel_level
    self.fuel_tank
  end

  protected
  attr_accessor :fuel_tank

end

module CustomClassMixin
  def debug(log)
    puts "DEBUG !!!: #{log}"
  end
end

module CustomMixedModuleMixin
  #ХАк для авто подключения миксинов
  def self.included(base)
    base.extend ClassMethods  #автоподключение методов класса
    base.send :include, InstanceMethods   #автоподключение методов инстанса
  end

  module ClassMethods
    def debug_advanced(log)
      puts "DEBUG ADVANCED !!!: #{log}"
    end
  end

  module InstanceMethods
    def debug_advanced(log)
      self.class.debug_advanced(log)
    end

    def print_class
      puts self.class
    end
  end
end


class Car

  include CustomMixin
  extend CustomClassMixin
  extend CustomMixedModuleMixin::ClassMethods #методы класса
  include CustomMixedModuleMixin::InstanceMethods #методж инстанса

  attr_reader :current_rpm

  @@instances = 0

  #метод класса
  class << self
    def instances
      @@instances
    end



  end



  def initialize
    @current_rpm = 0
    @@instances +=1

    #вызов метода класса
    self.class.debug('Инициализация Cars')
  end

  def start_engine
    start_engine! if engine_stopped?
  end


  def engine_stopped?
    current_rpm.zero?

  end



  protected

  attr_writer :current_rpm

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

end

class MotorCycle
  include CustomMixin

  include CustomMixedModuleMixin  #автоподключение метода класса и инстанса


  def initialize
    #вызов метода класса
    self.debug_advanced('Инициализация Motor')
  end

end


car = Car.new
byke = MotorCycle.new

car.fill_tank(20)
puts Car.instances
puts car.inspect

byke.fill_tank(30)
puts byke.inspect


puts "---------------"
car.print_class
car.debug_advanced('Бах')
Car.debug('буууу')
Car.debug_advanced('бууууd')
byke.debug_advanced('Бах moto')