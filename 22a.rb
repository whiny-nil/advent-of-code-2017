@debug = ENV['DEBUG'] == 'true'

# load the map
@map = File.readlines(__dir__ + '/inputs/22.txt').map(&:strip).map { |row| row.split('') }

# determine the center
center_x = (@map[0].length - 1) / 2
center_y = (@map.length - 1) / 2

puts [center_x, center_y].inspect if @debug
# pad the top and left of the map with .?

# start the bot
@x = center_x
@y = center_y
@dir = 'u'
@infections = 0

def infected?
  @map[@y][@x] == '#'
end

def infect
  @map[@y][@x] = '#'
  @infections += 1
end

def clean
  @map[@y][@x] = '.'
end

def turn_right
  case @dir
  when 'u' then @dir = 'r'
  when 'r' then @dir = 'd'
  when 'd' then @dir = 'l'
  when 'l' then @dir = 'u'
  end
end

def turn_left
  case @dir
  when 'u' then @dir = 'l'
  when 'l' then @dir = 'd'
  when 'd' then @dir = 'r'
  when 'r' then @dir = 'u'
  end
end

def move
  case @dir
  when 'u' then @y -= 1
  when 'd' then @y += 1
  when 'l' then @x -= 1
  when 'r' then @x += 1
  end

  if @x < 0 || @y < 0 || @y == @map.length
    extend_map
  end
end

def extend_map
  @map.unshift []
  @map.push []
  @map.each { |row| row.unshift '.' }
  @x += 1
  @y += 1
end

if @debug
  iterations = 10
else
  iterations = 10_000
end

iterations.times do |i|
  puts i
  if infected?
    turn_right
    clean
  else
    turn_left
    infect
  end

  move
end

puts @infections
