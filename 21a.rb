input = File.readlines(__dir__ + '/inputs/21.txt')

@patterns = input.map do |row|
  row.strip.split(' => ')
    .map { |el| el.split('/') }
    .map { |el| el.map { |le| le.split('') } }
end

def patterns
  @patterns
end

def segment(grid)
  new_grids = []
  size = grid.length
  if size % 3 == 0
    amt = grid.length / 3
    amt.times do
      amt.times do
        new_grid = []
        new_grid[0] = [grid[0].shift, grid[0].shift, grid[0].shift]
        new_grid[1] = [grid[1].shift, grid[1].shift, grid[1].shift]
        new_grid[2] = [grid[2].shift, grid[2].shift, grid[2].shift]
        new_grids << new_grid
      end
      grid.shift
      grid.shift
      grid.shift
    end
  else
    amt = grid.length / 2
    amt.times do
      amt.times do
        new_grid = []
        new_grid[0] = [grid[0].shift, grid[0].shift]
        new_grid[1] = [grid[1].shift, grid[1].shift]
        new_grids << new_grid
      end
      grid.shift
      grid.shift
    end
  end

  new_grids
end

def replace(grid)
  trial_grid = grid

  4.times do
    selection = patterns.select { |p| p[0] == trial_grid }
    return selection[0][1] if selection.length > 0

    trial_grid = flip trial_grid
    selection = patterns.select { |p| p[0] == trial_grid }
    return selection[0][1] if selection.length > 0

    trial_grid = rotate trial_grid
  end

  raise StandardError, "Pattern not found! (#{grid.inspect})"
end

def flip(grid)
  # horiz flip
  new_grid = []

  grid.length.times do |i|
    new_grid << grid[i].reverse
  end

  new_grid
end

def rotate(grid)
  if grid.length == 2
    new_grid = [[],[]]
    new_grid[0] = [grid[1][0], grid[0][0]]
    new_grid[1] = [grid[1][1], grid[0][1]]
  else
    new_grid = [[],[],[]]
    new_grid[0] = [grid[2][0], grid[1][0], grid[0][0]]
    new_grid[1] = [grid[2][1], grid[1][1], grid[0][1]]
    new_grid[2] = [grid[2][2], grid[1][2], grid[0][2]]
  end

  new_grid
end

def print(grid)
  grid.length.times do |i|
    puts grid[i].join(' ')
  end
  puts
end

def count(grid)
  count = 0

  grid.length.times do |i|
    count += grid[i].count('#')
  end

  count
end

grid = []

grid[0] = ['.', '#', '.']
grid[1] = ['.', '.', '#']
grid[2] = ['#', '#', '#']

1.times do
  new_grids = segment(grid)
  new_grids = new_grids.map { |grid| replace(grid) }
  new_grids.each { |g| print g }
  #grid = assemble(new_grids)
end

#print grid
puts count grid
