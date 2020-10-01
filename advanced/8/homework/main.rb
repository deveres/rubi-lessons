# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'valid.rb'
require_relative 'vendor.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'

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

def create_train
  puts 'Введите номер поезда?'
  train_num = gets.chomp
  raise "Поезд № #{train_num} уже существует" unless Train.find(train_num).nil?

  puts 'Какой тип у поезда (1- пассажирский, 2 - грузовой)?'
  train_type = gets.chomp.to_i
  raise 'Поезд не создан. Надо было ввести 1 или 2' unless [1, 2].include?(train_type)

  create_typed_train(train_type, train_num)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
  retry
end

def add_wagon
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  puts 'Введите номер поезда:'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  types = {
    'cargo' => lambda do
                 puts 'Введите объем вагона'
                 size = gets.chomp.to_f
                 train.add_wagon(CAR_TYPES[train.type].new(size))
               end,
    'passenger' => lambda do
                     puts 'Введите количество мест в вагоне'
                     size = gets.chomp.to_i
                     train.add_wagon(CAR_TYPES[train.type].new(size))
                   end
  }.freeze
  types[train.type].call if types.include?(train.type)
end

def load_car
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  puts 'Введите номер вагона'
  car_number = gets.chomp.to_i
  raise 'Такого вагона в поезде нет' if car_number > train.wagons.size

  if train.type == 'cargo'
    puts 'Введите объем груза'
    train.wagons[car_number - 1].load(gets.chomp.to_f)
  elsif train.type == 'passenger'
    train.wagons[car_number - 1].take_a_seat
  end
  puts 'Сделано'
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def remove_wagon
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  puts 'От какого поезда? (введите номер)'

  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  raise 'У этого поезда и так нет вагонов' if train.cars.empty?

  train.remove_car(train.cars.last)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def train_to_station
  raise 'Сначала необходимо создать поезд' if Train.all.empty?
  raise 'Сначала необходимо создать станцию' if Station.all.empty?

  puts 'Какой поезд? (введите номер)'
  number = gets.chomp

  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  puts 'На какую станцию? (название)'
  name = gets.force_encoding('CP866').encode('utf-8').chomp
  station = Station.all.detect { |stat| stat.name == name }

  raise 'Поезда с таким номером нет' if station.nil?

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

  puts 'На какой? (название)'
  name = gets.force_encoding('CP866').encode('utf-8').chomp
  station = Station.all.detect { |stat| stat.name == name }

  raise 'Такой станции нет' if station.nil?

  block = proc { |train| puts "№#{train.number} #{train.type} вагонов #{train.wagons.count}" }

  station.show_trains_by_type('cargo', block)
  station.show_trains_by_type('passenger', block)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def wagons_list
  raise 'Сначала необходимо создать поезд' if Train.all.empty?

  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  car_number = 0
  block = proc do |car|
    puts "№#{car_number += 1} #{train.type} свободно #{car.free}, занято #{car.filled}"
  end
  train.iterate_wagons(block)
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
