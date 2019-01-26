fibonacci = [1]
num = 1

while num < 100
  fibonacci << num
  num = fibonacci[-1] + fibonacci[-2]
end
