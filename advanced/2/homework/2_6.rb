name = ''

cart ={}

while name!='Стоп' do
  print "Введите название товара (или \"Cтоп\"): "
  name = gets.force_encoding('CP866').encode('utf-8').chomp

  if name!='Стоп'
    print "цену: "
    price = gets.chomp.to_f
    print "кол-во: "
    count = gets.chomp.to_f
    cart[name]={"price"=>price, "count"=>count}
  end


end

puts cart
sum=0

  cart.each do |name, hash|
    puts "Итого за \"#{name}\" #{hash["price"]*hash["count"]} руб"
    sum +=hash["price"]*hash["count"]
  end


puts "Общий итог:  #{sum}"
