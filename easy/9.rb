# работа   с файлами

File.open("text/simple.txt", 'r') do |file|
  #puts file.read() # читает весь файл

  #puts file.readline() #читает 1 строку

  for line in file.readlines
    puts "Строка"+line
  end

end


file = File.open("text/simple.txt", 'r')
puts file.read

file.close

File.open("text/simple.txt", 'a') do |file|
  file.write("ДОбавлено строка\n")
end


File.open("text/simple1.txt", 'w') do |file|
  file.write("ДОбавлено строка\n")
end