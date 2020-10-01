class Car

  attr_reader :current_rpm

  @@instances = 0

  #метод класса
  class << self
    def instances
      @@instances
    end

    def debug(log)
      puts "DEBUG !!!: #{log}"
    end

  end

  debug("ЗАгрузхили класс")

  def initialize
    @current_rpm = 0
    @@instances +=1

    #вызов метода класса
    self.class.debug('Инициализация')
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


car = Car.new
puts car.inspect
puts Car.instances
car1 = Car.new
puts car1.inspect
puts Car.instances