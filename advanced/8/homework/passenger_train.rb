class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def add_wagon(wagon)
    unless wagon.instance_of?(PassengerWagon)
      raise 'К пассажирскому поезду можно цеплять только пассажирские поезда'
    end

    super(wagon)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
