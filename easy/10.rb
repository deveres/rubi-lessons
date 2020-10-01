# отслеживание ошибок

list = [6,8,7,23,423,2,]


begin
  list["dd"]
  num = 10/0
rescue TypeError  =>e
  puts "TypeError"
  puts e
rescue ZeroDivisionError=>e
  puts "Деление на ноль"
  puts e
end
