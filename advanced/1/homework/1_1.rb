
puts ("Как вас зовут?")

name = gets.force_encoding('CP866').encode('utf-8').chomp()

puts ("Какой у вас рост в сантиметрах?")

height = gets.chomp()

idealWeight = height.to_i-110
if idealWeight>0
  puts "#{name}, ваш оптимальный вес #{idealWeight} кг."
else
  puts "Ваш вес уже оптимальный."
end

