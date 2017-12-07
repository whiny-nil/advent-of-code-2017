input = File.read(__dir__ + '/inputs/5.txt').split.map(&:to_i)

min = 0
max = input.length - 1
n = 1
el = 0
step = 0

while true do
  step = input[el]
  input[el] += 1
  el = el + step
  break if el < min || el > max
  n += 1
end

puts n
