input = File.read(__dir__ + "/inputs/6.txt").split("\s").map(&:to_i)

combos = [input]
first = -1
n = 0

loop do
  ary = Array.new combos[-1]
  max = ary.max
  start = ary.index(max)
  ary[start] = 0

  while max > 0
    start += 1
    start = 0 if start == ary.length
    ary[start] += 1
    max -= 1
  end

  combos << ary
  n += 1
  puts n if n % 1000 == 0

  first = combos.index(ary)
  break if first != (combos.length - 1)
end

puts [n, first, (combos.length - 1 - first)].inspect
