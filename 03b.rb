# Build a grid in a spiral pattern.
# Fill the grid with values as it is built.
# Value = sum of all surrounding number.
#
# Find the first number bigger than 312051
def grid
  @grid ||= {}
end

def calc_value(x, y)
  value = grid.fetch([x-1, y+1]) { 0 } +
          grid.fetch([x  , y+1]) { 0 } +
          grid.fetch([x+1, y+1]) { 0 } +
          grid.fetch([x-1, y  ]) { 0 } +
          grid.fetch([x+1, y  ]) { 0 } +
          grid.fetch([x-1, y-1]) { 0 } +
          grid.fetch([x  , y-1]) { 0 } +
          grid.fetch([x+1, y-1]) { 0 }

  raise value.inspect if value > 312051
  grid[[x,y]] = value
end

def build_square(n)
  if n == 0
    grid[[0,0]] = 1
  else
    # right side
    (-(n-1)..n).each do |y|
      grid[[n, y]] = 0
      calc_value(n, y)
    end

    # top side
    (-(n-1)..n).each do |x|
      grid[[-x, n]] = 0
      calc_value(-x, n)
    end

    # left side
    (-(n-1)..n).each do |y|
      grid[[-n, -y]] = 0
      calc_value(-n, -y)
    end

    # bottom side
    (-(n-1)..n).each do |x|
      grid[[x, -n]] = 0
      calc_value(x, -n)
    end
  end
end


n = 0
while #n < 4
  build_square n
  n += 1
end

puts @grid.inspect
