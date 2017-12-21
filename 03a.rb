def steps(input)
  # calculate ring number that contains input
  n = 0
  while input > (2 * n + 1)**2
    n += 1
  end
  # find midpoints of square
  midpoints = [0,1,2,3].map { |m| ((2 * n + 1)**2 - n) - (m * 2 * n) }

  # figure out min steps to midpoint

  steps_to_mid = midpoints.map {|m| (input - m).abs }.min
  # add steps to corner to ring number
  n + steps_to_mid
end

input = 312051

[1, 12, 23, 1024, input].each do |n|
  puts "#{n} : #{steps(n)}"
end
