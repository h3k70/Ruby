puts "Введите 1 сторону"
a = Float(gets.chomp)
puts "Введите 2 сторону"
b = Float(gets.chomp)
puts "Введите 3 сторону"
c = Float(gets.chomp)

if a==b && b==c 
	puts "Треугольник равносторонний"
else
	if a<b
		x = a
		a = b
		b = x
	end
	if a<c
		x = a
		a = c
		c = x
	end
	if (a**2) == ((b**2)+(c**2))
		print "Треугольник прямоугольный"
		puts " и равнобедренный" if b==c || b==a || a==c
	else
		print "Треугольник не прямоугольный"
		puts ", но равнобедренный" if b==c || b==a || a==c
	end
end