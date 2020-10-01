require_relative 'meta_module'

class A
  extend MetaModule

  attr_accessor_with_history :field1, :field2
  strong_attr_acessor :field4, String
  strong_attr_acessor :field5, Float


end


f = A.new
puts A.class_variables
#puts A.methods


puts f.field1
puts f.instance_variables
f.field1 = 23
f.field1 = 32
f.field2 = 58
f.field2 = 68
puts f.instance_variables
puts f.field1
puts f.field2
puts "field1 histyry\n"
puts f.field1_history
puts "field1 histyry\n"
puts f.field2_history

begin
f.field4 = 2
rescue RuntimeError=>e
  puts "Ошибка #{e}"
end
f.field4 = "текст"
puts f.field4

begin
  f.field5 = 2
rescue RuntimeError=>e
  puts "Ошибка #{e}"
end
f.field5 = 5.2
puts f.field5

