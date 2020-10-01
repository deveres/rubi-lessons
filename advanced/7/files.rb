
File.open('bloks.txt', 'a+') do |file|
  puts file.read
  file.write("gggg\n")
end



File.open('bloks.txt', 'a+').each do |line|
  puts line
end

