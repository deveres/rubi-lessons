
begin
  puts "Before exceprion"

  a = 2/0

rescue StandardError => e
  puts "Ошибка:" + e.message+ ' ' + e.class.name
  puts e.backtrace
  raise
rescue  NoMemoryError =>e
  puts "Ошибка:" + e.message
  puts e.backtrace

end

puts "After exceprion"