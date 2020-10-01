puts "Вводите первый коэффициент: "
a = gets.chomp().to_f

puts "Вводите второй коэффициент: "
b = gets.chomp().to_f

puts "Вводите третий коэффициент: "
c = gets.chomp().to_f


d = (b**2) - (4*a*c)

if d<0
  puts "Значение дискриминанта: #{d}. Корней нет."
elsif d==0
  puts "Значение дискриминанта: #{d}."

  puts "Х1 = Х2 = #{-1*b/(2*a)}."
else
  puts "Значение дискриминанта: #{d}."

  puts "Х1 = #{(-1*b+Math.sqrt(d))/(2*a)}."
  puts "Х2 = #{(-1*b-Math.sqrt(d))/(2*a)}."

end