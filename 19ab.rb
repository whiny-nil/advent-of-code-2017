#path = File.readlines(__dir__ + "/inputs/19-test.txt").map{ |row| row.split("") }
path = File.readlines(__dir__ + "/inputs/19.txt").map{ |row| row.split("") }

r = 0
c = path[r].index '|'
dir = 'd'
steps = 0
letters = []

loop do
  steps += 1
  char = path[r][c]

  case char
  when '|'
    # keep going
  when '-'
    # keep going
  when '+'
    if dir == 'd' || dir == 'u'
      l = path[r][c-1]
      if l == ' ' || l.nil?
        dir = 'r'
      else
        dir = 'l'
      end
    else
      u = path[r-1][c]
      if u == ' ' || u.nil?
        dir = 'd'
      else
        dir = 'u'
      end
    end
  when ' '
    steps -= 1
    break
  else
    letters.push char
  end

  case dir
  when 'd' then r += 1
  when 'u' then r -= 1
  when 'r' then c += 1
  when 'l' then c -= 1
  end

  break if r < 0 || c < 0 || path[r][c].nil?
end

puts [letters.join, steps]
