class PassengerTrain < Train

  def initialize(number, type='passenger')
    super
  end


  def add_wagon(wagon)
    if wagon.instance_of?(PassengerWagon)
      super(wagon)
    else
      puts "К пассажирскому поезду можно цеплять только пассажирские поезда"
    end
  end

end
