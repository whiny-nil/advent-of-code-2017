@debug = ENV['debug'] == 'TRUE'
puts 'debugging' if @debug

if @debug
  input = File.readlines(__dir__ + '/inputs/21-test.txt')
else
  input = File.readlines(__dir__ + '/inputs/21.txt')
end

@patterns = input.map do |row|
  row.strip.split(' => ')
    .map { |el| el.split('/') }
    .map { |el| el.map { |le| le.split('') } }
end

def patterns
  @patterns
end

def segment(grid)
  @grid = Marshal.load(Marshal.dump(grid))

  new_grids = []
  size = @grid.length
  if size % 2 == 0
    amt = @grid.length / 2
    amt.times do
      amt.times do
        new_grid = []
        new_grid[0] = [@grid[0].shift, @grid[0].shift]
        new_grid[1] = [@grid[1].shift, @grid[1].shift]
        new_grids << new_grid
      end
      @grid.shift
      @grid.shift
    end
  else
    amt = @grid.length / 3
    amt.times do
      amt.times do
        new_grid = []
        new_grid[0] = [@grid[0].shift, @grid[0].shift, @grid[0].shift]
        new_grid[1] = [@grid[1].shift, @grid[1].shift, @grid[1].shift]
        new_grid[2] = [@grid[2].shift, @grid[2].shift, @grid[2].shift]
        new_grids << new_grid
      end
      @grid.shift
      @grid.shift
      @grid.shift
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

    trial_grid = flip trial_grid
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

def assemble(grids)
  new_grid = []
  size = grids[0].length

  amt = Math.sqrt(grids.length).to_i
  amt.times do
    row0 = []
    row1 = []
    row2 = [] if size >= 3
    row3 = [] if size == 4
    amt.times do
      grid = grids.shift
      row0 << grid[0]
      row1 << grid[1]
      row2 << grid[2] if size >= 3
      row3 << grid[3] if size == 4
    end
    new_grid << row0.flatten
    new_grid << row1.flatten
    new_grid << row2.flatten if size >= 3
    new_grid << row3.flatten if size == 4
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

if @debug
  grid = []
  grid << ['1', '2']
  grid << ['3', '4']

  print grid
  print flip(grid)
  print rotate(grid)

  grid = []
  grid << ['1', '2', '3']
  grid << ['4', '5', '6']
  grid << ['7', '8', '9']

  print grid
  print flip(grid)
  print rotate(grid)

  grid = []
  grid << ['01', '02', '03', '04']
  grid << ['05', '06', '07', '08']
  grid << ['09', '10', '11', '12']
  grid << ['13', '14', '15', '16']

  print grid
  grids = segment grid
  grids.each { |g| print g }
  new_grid = assemble grids
  print new_grid
end



grid = []

grid[0] = ['.', '#', '.']
grid[1] = ['.', '.', '#']
grid[2] = ['#', '#', '#']

18.times do |i|
  puts i
  new_grids = segment(grid)
  if @debug
    test_grids = Marshal.load(Marshal.dump(new_grids))
    new_grid = assemble test_grids
    unless grid == new_grid
      puts i
      puts grid.inspect
      puts new_grids.inspect
      puts new_grid.inspect
      raise StandardError
    end
  end
  new_grids = new_grids.map { |grid| replace(grid) }
  grid = assemble new_grids
  #print grid
end

if @debug
  puts [count(grid), 2480380].inspect
else
  puts count(grid)
end
