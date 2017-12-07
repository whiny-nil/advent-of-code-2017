input = File.read(__dir__ + '/inputs/5.txt').split.map(&:to_i)

min = 0
max = input.length - 1
n = 1
el = 0
step = 0

while true do
  step = input[el]
  if step >= 3
    input[el] -= 1
  else
    input[el] += 1
  end
  el = el + step
  break if el < min || el > max
  n += 1
end

puts n
