class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]


    puts "Создан маршрут #{from.name} - #{to.name}"
  end

  def add_station(station)
    stations.insert(-2, station)
    puts "К маршруту #{self.name} добавлена станция #{station.name}"

  end

  def remove_station(station)
    if [stations.first , stations.last].include?(station)
      puts "Нельзя удалять первую и последнюю станцию"
    else
      stations.delete(station)
      puts "Из маршрута #{self.name} удалена станция #{station.name}"
    end

  end

  def show_stations
    puts "В маршрут  #{self.name} входят станции:"

    stations.each { |station| puts station.name }
  end


  def name
    stations.first.name + " - " + stations.last.name
  end

end
