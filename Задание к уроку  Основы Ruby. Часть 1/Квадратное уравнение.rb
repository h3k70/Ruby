print "a = "
a = Float(gets.chomp)
print "b = "
b = Float(gets.chomp)
print "c = "
c = Float(gets.chomp)

d = (b**2) - (4*a*c)
if d < 0
	puts "d = #{d} корней нет"
else
	x1 = (-b + Math.sqrt(d))/(2*a)
	x2 = (-b - Math.sqrt(d))/(2*a)
	if x1 != x2
		puts "d = #{d}, корни x1 = #{x1} и x2 = #{x2}" 
	else
		puts "d = #{d}, корень x = #{x1}" 
	end
end