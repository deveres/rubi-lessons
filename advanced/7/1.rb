

a = Proc.new {|x| x=x*10; puts x}
b = proc {|x| x=x*10; puts x}
c = lambda {|x| x=x*10; puts x} #аргументы должны совпадать

a.call(1,2,3,4)
b.call(1,2,3,4)
c.call(1)


# блок это замыкание
x="hello"
block = Proc.new { puts x}
def m1(block)
  x="bye|"
  puts "X from method: #{x}"
  block.call

end
m1(block)

# передача блоков
# 1- не как именнои аргумент-
# без параметра
def m2
  puts "before blok"
  yield
  puts "after blok"
end
m2 {puts "inside block"}

#с параметром
def caps(str)
  str.capitalize!
  yield(str)
end
caps("abc") {|str| puts str}

# передача блоков
# 2- как именнои аргумент-
def caps1(str, block)
  str.capitalize!
  block.call(str)
end
block1= lambda{|x| puts x}
caps1("bcdf", block1)

#3-
def caps3(str, &block)
  str.capitalize!
  block.call(str)
end
caps3("bcdf") {|x| puts x}

# передан ли блок
def caps4(str, &block)

  if block_given?
    str.capitalize!
    block.call(str)
  else
    puts str
  end
end
caps4("bcdf")
caps4("bcdf") {|x| puts x}



