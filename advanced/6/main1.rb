def method_with_error
  raise ArgumentError,"Oh no!"
end

begin
  method_with_error
rescue ArgumentError=>e
 puts e.inspect
end

puts "Aftrer"