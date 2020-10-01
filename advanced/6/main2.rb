def connect_to_wikipedia
  #---
  raise "Connection error"
end

attempt = 0
begin
  connect_to_wikipedia
rescue RuntimeError
  attempt+=1
  puts "Check yout connection"
  retry if attempt < 3

ensure
  #выполнять в лбюом случае
  puts "total #{attempt} attempts"
end

