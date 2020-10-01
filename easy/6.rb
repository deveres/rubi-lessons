# методы и операторы ретурн

def sayHello
  puts "Привет Мир!"
end


def sayHelloParams(word, num=0)
  puts "Привет Мир!"
  puts "Ваше слово: "+ word + " и ваше число: "+num.to_s
end

def sum(x, y)
  return x+y
end

def sumMultiple(x, y)
  return x+y, 2
end

puts "1"
sayHello
puts "2"
sayHelloParams("Бум", 34)
sayHelloParams("Бум1")

res = sum(2,3)
puts(res)

res1 = sumMultiple(4, 5)
puts(res1[0], res1[1])