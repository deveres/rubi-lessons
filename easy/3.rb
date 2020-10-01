#строки и математические действия

words = "привет Веб сайт \"не\" назову"
word = "!  "
puts(words+word)
puts(words.upcase())
puts(words.downcase())

puts(words.strip())
puts('--')
puts(words.capitalize())

puts('--')
puts("Саша".center(11, "-"))

puts('--')
puts(words.length())

puts('--')
puts(words.include?"Веб")

puts('--')
puts(words.chomp())

x = 5
y = 11

res = x+y
puts(res)
res = x-y
puts(res)
res = x*y
puts(res)
res = x/y
puts(res)
res = x**y
puts(res)
res = y%x
puts(res)

puts(Math.sqrt(144))


puts("Результат остатка от деления " + res.to_s)