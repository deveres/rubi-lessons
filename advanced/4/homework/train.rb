
class Train
  attr_reader :type
  attr_accessor :speed, :number, :wagons, :route, :station

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed=0

  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    if speed.zero?
      self.wagons << wagon
      puts "К поезду #{number} добавлен вагон. Теперь их #{wagons.length}."
    else
      puts "Нельзя добавлять вагоны в движении"
    end
  end

  def remove_wagon(wagon)
    if !wagons.include?(wagon)
      puts "Поезд не имеет такого вагона"
    elsif speed.zero?
      self.wagons.delete(wagon)
      puts "От поезда #{number} отцепили вагон. Теперь их #{wagons.length}."
    else
      puts "Нельзя отцепить вагоны в движении"
    end
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}"
  end


  def go_to(station)
    if route.nil?
      puts "Без маршрута поезд заблудится."
    elsif @station == station
      puts "Поезд №#{@number} и так на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "Станция #{station.name} не входит в маршрут поезда №#{number}"
    end
  end

  def stations_around
    if route.nil?
      puts "Маршрут не задан"
    else
      station_index = route.stations.index(station)
      puts "Сейчас поезд на станции #{station.name}."
      puts "Предыдущая станция - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Следующая - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end
end