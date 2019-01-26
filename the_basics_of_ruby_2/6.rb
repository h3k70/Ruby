box = {}

loop do

  puts "Введите название товара(для выхода введет \"stop\""

  name = gets.chomp
  break if name == 'stop'
  
  puts "Введите цену за единицу"
  price = gets.to_f

  puts "Введите кол-во купленного товара"
  quantity = gets.to_f

  box[name] = { price: price, quantity: quantity }
end

puts box

total = 0
box.each do |name, info|
  total_product_price = info[:price] * info[:quantity]
  total += total_product_price
  puts "Итоговая сумма за #{name} = #{total_product_price}"
end

puts "Итоговая сумма всех покупок = #{total}"
