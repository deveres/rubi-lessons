def sqrt(value)
  sqrt = Math.sqrt(value)
  puts sqrt
rescue StandardError
  puts "Опс"


end

sqrt(-1)
