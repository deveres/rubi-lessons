class Station
  include InstanceCounter
  include Validation

  @@stations = []
  attr_reader :name
  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []

    validate!

    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def get_train(train)
    raise "Поезд №#{train.number} и так на станции  #{name}" if @trains.include?(train)

    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  def show_trains_by_type(type, block)
    raise 'На станции нет поездов.' if @trains.empty?
    raise 'Не указан тип поезда.' if type.nil?

    puts "Поезда на станции #{name} типа #{type}: "
    if block_given?
      apply_trains_block(type, block)
    else
      @trains.each { |train| puts train.number if train.type == type }
    end
  end

  def show_all_trains(&block)
    raise 'На станции нет поездов.' if @trains.empty?

    puts "Поезда на станции #{name}: "
    if block_given?
      @trains.each { |train| block.call(train) }
    else
      @trains.each { |train| puts train.number }
    end
  end

  private

  def apply_trains_block(type, block)
    @trains.each { |train| block.call(train) if train.type == type }
  end
end
