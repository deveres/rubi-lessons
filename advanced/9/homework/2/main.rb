# frozen_string_literal: true

require_relative 'modules/validate'
require_relative 'modules/instance_counter.rb'
require_relative 'modules/vendor.rb'
require_relative 'models/station.rb'
require_relative 'models/route.rb'
require_relative 'models/train.rb'
require_relative 'models/wagon.rb'
require_relative 'models/passenger_wagon.rb'
require_relative 'models/cargo_wagon.rb'
require_relative 'models/passenger_train.rb'
require_relative 'models/cargo_train.rb'

CAR_TYPES = { 'cargo' => CargoWagon, 'passenger' => PassengerWagon }.freeze

puts %(
0. Выход
1. Создать станцию
2. Создать поезд
3. Прицепить вагон к поезду
4. Отцепить вагон от поезда
5. Поместить поезд на станцию
6. Просмотреть список станций
7. Просмотреть список поездов на станции
8. Просмотреть список вагонов у поезда
9. Занять место/объем в вагоне
  )

def create_station
  puts 'Введите название станции?'
  name = gets.force_encoding('CP866').encode('utf-8').chomp
  Station.new(name)
  puts "Построена станция #{name}"
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def create_typed_train(train_type, train_num)
  case train_type
  when 1
    PassengerTrain.new(train_num)
    puts "Создан новый пассажирский поезд #{train_num}"
  when 2
    CargoTrain.new(train_num)
    puts "Создан новый грузовой поезд #{train_num}"
  end
end

def input_train_num
  puts 'Введите номер поезда?'
  train_num = gets.chomp
  raise "Поезд № #{train_num} уже существует" unless Train.find(train_num).nil?

  train_num
end

def input_train_type
  puts 'Какой тип у поезда (1- пассажирский, 2 - грузовой)?'
  train_type = gets.chomp.to_i
  raise 'Поезд не создан. Надо было ввести 1 или 2' unless [1, 2].include?(train_type)

  train_type
end

def create_train
  train_num = input_train_num
  train_type = input_train_type

  create_typed_train(train_type, train_num)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
  retry
end

def add_wagon_cargo(train)
  puts 'Введите объем вагона'
  size = gets.chomp.to_f
  train.add_wagon(CAR_TYPES[train.type].new(size))
end

def add_wagon_passenger(train)
  puts 'Введите количество мест в вагоне'
  size = gets.chomp.to_i
  train.add_wagon(CAR_TYPES[train.type].new(size))
end

def add_wagon
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  train = input_train('Введите номер поезда:')

  add_wagon_cargo(train) if train.type == 'cargo'
  add_wagon_passenger(train) if train.type == 'passenger'
end

def load_car_action(train, car_number)
  if train.type == 'cargo'
    puts 'Введите объем груза'
    train.wagons[car_number - 1].load(gets.chomp.to_f)
  elsif train.type == 'passenger'
    train.wagons[car_number - 1].take_a_seat
  end

  puts 'Сделано'
end

def input_train(msg = '')
  puts msg || 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  train
end

def input_wagon
  puts 'Введите номер вагона'
  car_number = gets.chomp.to_i
  car_number
end

def load_car
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  train = input_train
  car_number = input_wagon
  raise 'Такого вагона в поезде нет' if car_number > train.wagons.size

  load_car_action(train, car_number)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def remove_wagon
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  train = input_train('От какого поезда? (введите номер)')
  raise 'У этого поезда и так нет вагонов' if train.cars.empty?

  train.remove_car(train.cars.last)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def input_station(msg = '')
  puts msg || 'На какую станцию? (название)'
  name = gets.force_encoding('CP866').encode('utf-8').chomp
  station = Station.all.detect { |stat| stat.name == name }
  station
end

def train_to_station
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  raise 'Сначала необходимо создать станцию' if Station.all.empty?

  train = input_train('Какой поезд? (введите номер)')
  station = input_station('На какую станцию? (название)')
  raise 'Нет такой станции' if station.nil?

  station.get_train(train)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def stations_list
  raise 'Нет созданных станций' if Station.instances.nil?

  puts 'Список станций:'
  Station.all.each { |station| puts station.name }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def trains_list
  raise 'Нет созданных станций' if Station.all.empty?

  station = input_station('На какой? (название)')
  raise 'Такой станции нет' if station.nil?

  format = proc { |train| puts "№#{train.number} #{train.type} вагонов #{train.wagons.count}" }

  station.show_trains_by_type('cargo', format)
  station.show_trains_by_type('passenger', format)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def wagons_list
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  train = input_train('Введите номер поезда')

  car_number = 0
  format = proc do |car|
    puts "№#{car_number += 1} #{train.type} свободно #{car.free}, занято #{car.filled}"
  end
  train.iterate_wagons(format)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

loop do
  print 'Введите номер команды: '
  command = gets.chomp
  commands = {
    '1' => -> { create_station },
    '2' => -> { create_train },
    '3' => -> { add_wagon },
    '4' => -> { remove_wagon },
    '5' => -> { train_to_station },
    '6' => -> { stations_list },
    '7' => -> { trains_list },
    '8' => -> { wagons_list },
    '9' => -> { load_car }
  }.freeze

  if command == '0'
    puts 'До новых встреч!'
    break
  end

  if commands.include?(command)
    commands[command].call

  else
    puts 'Нет такой комманды'
  end
end
