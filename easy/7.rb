#7 - Условные операторы (if else и case when)

x = 8
y = 2
if x < y
  puts("x меньше y")
  puts("!")
elsif x == y
  puts("x равно У")
else
  if x>6
    puts "Х больше 6"
  end
  puts "х либо равно либо больше Y"
end

isSmall = true
if isSmall==true and x ==8
  puts :okman
end


def getDayOfWeek(day)
  nameOfDay=""

  case day
  when "1"
    nameOfDay="Понедельник"
  when "2"
    nameOfDay="Вторник"
  when "3"
    nameOfDay="Среда"
  when "4"
    nameOfDay="Четверг"
  when "5"
    nameOfDay="Пятница"
  when "6"
    nameOfDay="Суббота"
  when "7"
    nameOfDay="Восскресение"
  else
    nameOfDay="Нет такого дня"
  end

  return nameOfDay
end


puts(getDayOfWeek("11"))