class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

  def initialize(number)
    super(number, 'cargo')
  end

  def add_wagon(wagon)
    raise 'К грузовому поезду можно прицеплять только грузовые вагоны' unless wagon.instance_of?(CargoWagon)

    super(wagon)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
