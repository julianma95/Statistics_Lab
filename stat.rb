f = File.new("./act.csv" , "r")
data_string = f.read
f.close

data_array = data_string.split("\r")
firstrow = data_array.shift
r = 0

data_array.each do |x|
  data_point = x.split(',')
data_value = data_point[1].to_f
r = r + data_value
end

avg = r/557
n = 0
u = avg

data_array.each do |x|
  data_point = x.split (',')
  data_value = data_point[1].to_f
  num = (data_value-u)**2
  n = n + num
end

stdev = (n/557)**0.5

new_array =[]
data_array.each do |x|
  data_point = x.split (',')
  data_value = data_point[1].to_f
  zscore = (data_value-u)/stdev
new_array.push zscore
end

final_array = []
557.times do |i|
final_array.push data_array[i].to_s + "," + new_array[i].to_s
end
final_array.unshift(firstrow)

f = File.new("./act2.csv" , "w")
f.write final_array.join ("\n")
f.close

