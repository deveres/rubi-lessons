class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

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
