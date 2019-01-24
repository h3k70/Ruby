puts "Введите 1 сторону"
a = gets.to_f
puts "Введите 2 сторону"
b = gets.to_f
puts "Введите 3 сторону"
c = gets.to_f

cathetus_a, cathetus_b, hypotenuse = [a, b, c].sort!

rigth_triangle = cathetus_a ** 2 + cathetus_b ** 2 == hypotenuse ** 2 # прямоугольный
isosceles_triangle = cathetus_b == hypotenuse || cathetus_a == cathetus_b # равнобедренный
equilateral_triangle = cathetus_a == hypotenuse # равносторонний

if equilateral_triangle 
  puts "Треугольник равносторонний"

else

  if rigth_triangle
    print "Треугольник прямоугольный"
    puts " и равнобедренный" if isosceles_triangle
  else
    print "Треугольник не прямоугольный"
    puts ", но равнобедренный" if isosceles_triangle
  end
end
