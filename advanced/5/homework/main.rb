require_relative 'instance_counter.rb'
require_relative 'vendor.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'

stations =[]
trains = []

CAR_TYPES = {'cargo' => CargoWagon, 'passenger' => PassengerWagon}

puts %Q(
0. Выход
1. Создать станцию
2. Создать поезд
3. Прицепить вагон к поезду
4. Отцепить вагон от поезда
5. Поместить поезд на станцию
6. Просмотреть список станций
7. Просмотреть список поездов на станции
  )

command = '';
while command!=0 do
  print "Введите номер команды: "
  command = gets.chomp.to_i

  case command
  when 0
    puts "До новых встреч!"
  when 1
    puts "Введите название станции?"
    name = gets.force_encoding('CP866').encode('utf-8').chomp
    stations << Station.new(name)
    puts "Построена станция #{name}"
  when 2 #Создать поезд
    puts "Введите номер поезда?"
    train_num = gets.chomp.to_i
    puts "Какой тип у поезда (1- пассажирский, 2 - грузовой)?"
    train_type = gets.chomp.to_i
    case train_type
    when 1
      trains << PassengerTrain.new(train_num)
      puts "Создан новый пассажирский поезд #{train_num}"
    when 2
      trains << CargoTrain.new(train_num)
      puts "Создан новый грузовой поезд #{train_num}"
    else
      puts "Такой тип поезда не доступен"
    end

  when 3 #Прицепить вагон к поезду
    if trains.empty?
      puts "Нет поездов"
    else
      puts "Введите номер поезда:"
      number = gets.chomp.to_i
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "Поезда с таким номером нет"
      else
        train.add_wagon(CAR_TYPES[train.type].new)
      end
    end
  when 4 #Отцепить вагон от поезда
    if trains.empty?
      puts "Сначала необходимо создать поезд"
    else
      puts "От какого поезда? (введите номер)"
      number = gets.chomp.to_i
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "Поезда с таким номером нет"
      elsif train.cars.empty?
        puts "У этого поезда и так нет вагонов"
      else
        train.remove_car(train.cars.last)
      end
    end

  when 5 #Поместить поезд на станцию
    if trains.empty?
      puts "Сначала необходимо создать поезд"
    elsif stations.empty?
      puts "Сначала необходимо создать станцию"
    else
      puts "Какой поезд? (введите номер)"
      number = gets.chomp.to_i
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "Поезда с таким номером нет"
      else
        puts "На какую станцию? (название)"
        name = gets.force_encoding('CP866').encode('utf-8').chomp
        station = stations.detect{|station| station.name == name}
        if station.nil?
          puts "Такой станции нет"
        else
          station.get_train(train)
        end
      end
    end
  when 6 #Просмотреть список станций
    puts "Список станций:"
    stations.each{|station| puts station.name}

  when 7 #Просмотреть список поездов на станции
    if stations.empty?
      puts "Сначала необходимо создать станцию"
    else
      puts "На какой? (название)"
      name = gets.force_encoding('CP866').encode('utf-8').chomp
      station = stations.detect{|station| station.name == name}
      if station.nil?
        puts "Такой станции нет"
      else
        station.show_trains
      end
    end



  else
    puts "Нет такой комманды"
  end

end
