
alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"

vowels = "аеёиоуыэюя"

vowels_hash = {}

for i in 0..vowels.length-1
  vowels_hash[vowels[i]] = alphabet.index(vowels[i])+1
end

puts vowels_hash