print "a = "
a = gets.to_f
print "b = "
b = gets.to_f
print "c = "
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "d = #{d} корней нет"
else
	d_sqrt = Math.sqrt(d)
  x1 = (-b + d_sqrt) / (2.0 * a)
  x2 = (-b - d_sqrt) / (2.0 * a)
  if x1 != x2
    puts "d = #{d}, корни x1 = #{x1} и x2 = #{x2}" 
  else
    puts "d = #{d}, корень x = #{x1}" 
  end
end
