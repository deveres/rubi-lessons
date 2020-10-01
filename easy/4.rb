#получение данных от юзера
#puts("введите свое имя")
#name = gets.force_encoding('CP866').encode('utf-8').chomp()
#puts(name)
#puts("Ваше имя "+name)
puts("калькулятор")
print("Введите первое число: ")
x= gets.chomp().strip().to_f
print("Введите второе число: ")
y= gets.chomp().strip().to_f
puts(x+y)