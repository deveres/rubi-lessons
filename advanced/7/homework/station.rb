# frozen_string_literal: true

class Station
  include InstanceCounter
  include Valid
  @@stations = []
  attr_reader :name

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

  def show_trains(type = nil, &block)
    raise 'На станции нет поездов.' if @trains.empty?

    if type
      puts "Поезда на станции #{name} типа #{type}: "
      if block_given?
        @trains.each { |train| block.call(train) if train.type == type }
      else
        @trains.each { |train| puts train.number if train.type == type }
      end
    else
      puts "Поезда на станции #{name}: "
      if block_given?
        @trains.each { |train| block.call(train) }
      else
        @trains.each { |train| puts train.number }
      end
    end
  end

  protected

  def validate!
    raise 'Название станции не может быть пустым, попробуйте еще раз.' if name.empty?
  end
end
