# frozen_string_literal: true

# class  train
class Train
  include InstanceCounter
  include Vendor
  include Valid

  attr_reader :type
  attr_accessor :speed, :number, :wagons, :route, :station

  TRAIN_NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/iu.freeze
  include Vendor
  @@trains = {}

  class << self
    def find(num)
      @@trains[num]
    end

    def all
      @@trains
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0

    validate!
    @@trains[number] = self
    register_instance
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    raise 'Нельзя добавлять вагоны в движении' unless speed.zero?

    wagons << wagon
    puts "К поезду #{number} добавлен вагон. Теперь их #{wagons.length}."
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def remove_wagon(wagon)
    raise  'Нельзя отцепить вагоны в движении' unless speed.zero?
    raise  'Поезд не имеет такого вагона' unless wagons.include?(wagon)

    wagons.delete(wagon)
    puts "От поезда #{number} отцепили вагон. Теперь их #{wagons.length}."
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}"
  end

  def iterate_wagons(&block)
    raise 'К поезду не прицеплено вагонов' if @wagons.empty?

    @wagons.each { |wagon| block.call(wagon) }
  end

  def go_to(station)
    raise 'Без маршрута поезд заблудится.' if route.nil?
    raise "Поезд №#{@number} и так на станции #{@station.name}" if @station == station
    raise "Станция #{station.name} не входит в маршрут поезда №#{number}" unless route.stations.include?(station)

    @station&.send_train(self)
    @station = station
    station.get_train(self)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def stations_around
    raise 'Маршрут не задан' if route.nil?

    station_index = route.stations.index(station)
    puts "Сейчас поезд на станции #{station.name}."
    puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
    puts "Следующая - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  protected

  def validate!
    raise 'Не правильный формат' if number !~ TRAIN_NUMBER
  end
end
