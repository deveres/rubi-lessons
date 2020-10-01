puts "Вводите величину первой стороны треугольника (см): "
a = gets.chomp().to_f

puts "Вводите второй стороны треугольника (см): "
b = gets.chomp().to_f

puts "Вводите третьей стороны треугольника (см): "
c = gets.chomp().to_f

sides = [a, b, c]

hipotenuse = sides.max  #узнаем значение гипотенузы
whichIsHipotenuse = sides.find_index(hipotenuse) #узнаем позицию гипотенузы
sides.delete_at(whichIsHipotenuse)  #удаляем из массива гипотенузу
puts('------')
puts(hipotenuse**2)
puts('------')
puts(sides)
puts(sides[0]**2)
puts(sides[1]**2)
puts('------')
if a+b+c == a*3
  puts "Это равнобедренный равносторонний треугольник"
elsif (hipotenuse**2)==(sides[0]**2+sides[1]**2)
  puts "Это прямоугольный треугольник"

  if (sides[0]==sides[1])

    puts "Это еще и равнобедренный треугольник"
  end
elsif a==b || b==c || a==c
  puts "Это равнобедренный треугольник"
else
  puts "Это не прямоугольный треугольник, не равнобедренный, и не равносторонний"
end

