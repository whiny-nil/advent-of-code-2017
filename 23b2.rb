require 'prime'
@debug = ENV['DEBUG'] == 'true'

b = c = d = e = f = g = h = 0

b = c = 93
unless  @debug
  b = 109_300
  c = 126_300
end

mult = 0 if @debug

loop do
  # f = 1
  # d = 2
  # loop do
  #   e = 2
  #   loop do
  #     mult += 1 if @debug
  #     f = 0 if (d * e - b) == 0
  #     e += 1
  #     g = e - b
  #     break if g == 0
  #   end
  #   d += 1
  #   g = d - b
  #   break if g == 0
  # end

  # h += 1 if f == 0
  h += 1 unless Prime.prime? b
  g = b - c
  break if g == 0
  b += 17
end

puts mult if @debug
puts h
