# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def add_wagon(wagon)
    raise 'К пассажирскому поезду можно цеплять только пассажирские поезда' unless wagon.instance_of?(PassengerWagon)

    super(wagon)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
