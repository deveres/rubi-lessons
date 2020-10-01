class CargoTrain < Train
  def initialize(number, type='cargo')
    super
  end

  def add_wagon(wagon)
    if wagon.instance_of?(CargoWagon)
      super(wagon)
    else
      puts "К грузовому поезду можно цеплять только грузовые поезда"
    end
  end
end
