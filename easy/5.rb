# Массивы и ассоциативные массивы

arr = [1, "2",3 ,5,6,8, "Вася", true, 5.67]

puts(arr)

names= ["Диана","Alex", 'Ира']
puts(names[1])
puts(names[-1])
puts(names[1,2])
names[2]="Муму"
puts(names)

list = Array.new
list[1] = "ss"
puts(list)

puts(list.length)
puts(names.reverse)

puts(arr.include?3)

countries = {
    "ru"=>"Россия",
    1=>1.01,
    :UA=>'Украина'
}

puts(countries)
puts(countries[:UA])