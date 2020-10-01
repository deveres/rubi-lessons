# frozen_string_literal: true

# caRGO CLASS
class CargoTrain < Train
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
