steps = 355
#steps = 3
iter = 2017
# iter = 9
circ = [0]
curr_pos = 0

(1..iter).each do |i|
  circ.rotate! steps
  circ.insert 0, i
  circ.rotate!
end

ind = circ.index iter
ind = 0 if ind == circ.length - 1

puts circ[ind]
