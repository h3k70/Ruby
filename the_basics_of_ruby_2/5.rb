puts "Введите день"
day = gets.to_i

puts "Введите месяц"
month = gets.to_i

puts "Введите год"
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0

months[1] += 1 if leap_year

date_num = day + months.take(month - 1).sum

puts "Порядковый номер даты, начиная отсчет с начала года - #{date_num}"
