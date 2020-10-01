class Car

  attr_reader :current_rpm

  attr_accessor :number

  NUMBER_FORMAT = /^[а-я]{1}\d{3}[а-я]{2}$/i

  def initialize(num)
    @current_rpm = 0
    @number = num
    validate!
  end

  def start_engine
    start_engine! if engine_stopped?
  end


  def engine_stopped?
    current_rpm.zero?
  end


  def valid?
    validate!
  rescue
    false

  end

  protected

  attr_writer :current_rpm

  def validate!
    raise "Номер не может быть пустои " if number.nil?
    raise "Номер должен иметь минимум 6 символов " if number.length<6
    #raise "Неправильный формат" if number =~ /^[а-яА-Я]{1}\d{3}[а-яА-Я]{3}$/
    raise "Неправильный формат" if number !~ NUMBER_FORMAT
    true
  end


  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end




end


#car = Car.new("123")
#puts car.inspect

#car1 = Car.new("123423432")
#puts car1.inspect

car2 = Car.new("В123РБ")
puts car2.inspect

puts car2.valid?