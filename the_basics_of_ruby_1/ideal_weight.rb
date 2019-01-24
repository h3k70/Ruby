puts "Как Вас зовут?"
name = gets.chomp.capitalize!

puts "Какой у Вас рост?"
height = gets.to_i
ideal_weight = height - 110

if ideal_weight < 0 
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес - #{ideal_weight}"
end
