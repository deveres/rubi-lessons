#циклы while  for

i=0
while i<10
  puts(i)
  i +=1
end

secret = "Ваня"
guess = ""

#while guess != secret
#  puts "Как его зовут?"
#  guess = gets.force_encoding('CP866').encode('utf-8').chomp()
#end

#puts "Ты угадал имя"

for el in 1..5
  puts el
end

names = ["BOb", 'James', 'Dina', 'Alex', 'Jorje']
for name in names
  puts (name)
end

for el in 0..names.length()-1
  names[el] +="1"
end

puts names
puts "---"
6.times do |index|
  puts(index)
end

names.each do |index|
  puts index
end