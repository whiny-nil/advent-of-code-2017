@debug = ENV['debug'] == 'true'

b = c = d = e = f = g = h = 0

if @debug
  b = c = 93
else
  b = 109_300
  c = 126_300
end

mult = 0

loop do
  f = 1
  d = 2
  loop do
    e = 2
    loop do
      g = d
      g *= e
      mult += 1
      g -= b
      f = 0 if g == 0
      e += 1
      g = e
      g -= b
      break if g == 0
    end
    d += 1
    g = d
    g -= b
    break if g == 0
  end

  h += 1 if f == 0
  g = b

  g -= c
  break if g == 0
  b += 17
end

puts mult
