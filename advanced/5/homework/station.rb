class Station

  include InstanceCounter

  attr_reader :name

  @@stations = []

  class << self
    def all
      @@stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self

    register_instance

  end

  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end


  def show_trains(type=nil)
    if type
      puts "Поезда на станции #{self.name} типа #{type}: "
      @trains.each { |train| puts train.number if train.type==type }
    else
      puts "Поезда на станции #{self.name}: "
      @trains.each { |train| puts train.number }
    end
  end

end