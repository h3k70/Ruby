puts "Как Вас зовут?"
name = gets.chomp
name.capitalize!

puts "Какой у Вас рост?"
height = Integer(gets.chomp)
if (height-110) < 0 
	puts "#{name}, Ваш вес уже оптимальный"
else
	puts "#{name}, Ваш идеальный вес - #{height-110}"
end