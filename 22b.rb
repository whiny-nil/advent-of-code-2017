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

def weakened?
  @map[@y][@x] == 'W'
end

def infected?
  @map[@y][@x] == '#'
end

def flagged?
  @map[@y][@x] == 'F'
end

def infect
  @map[@y][@x] = '#'
  @infections += 1
end

def flag
  @map[@y][@x] = 'F'
end

def clean
  @map[@y][@x] = '.'
end

def weaken
  @map[@y][@x] = 'W'
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

def reverse
  case @dir
  when 'u' then @dir = 'd'
  when 'l' then @dir = 'r'
  when 'd' then @dir = 'u'
  when 'r' then @dir = 'l'
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
  iterations = 1_000
else
  iterations = 10_000_000
end

iterations.times do |i|
  puts i if i % 100_000 == 0
  if weakened?
    # keep going
    infect
  elsif infected?
    turn_right
    flag
  elsif flagged?
    reverse
    clean
  else #clean
    turn_left
    weaken
  end

  move
end

puts @infections
