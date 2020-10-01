class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end

  def add_wagon(wagon)
    unless wagon.instance_of?(CargoWagon)
      raise 'К грузовому поезду можно прицеплять только грузовые вагоны'
    end

    super(wagon)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end
end
