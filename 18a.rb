instructions = File.readlines(__dir__ + "/inputs/18.txt").map(&:strip).map(&:split)
i = 0
@registers = Hash.new 0
last_sound = 0

def get_value(x)
  if x.match /[a-z]/
    @registers[x]
  else
    x.to_i
  end
end


loop do
  offset = 1
  instruction = instructions[i]

  case instruction[0]
  when 'snd'
    value = get_value instruction[1]
    last_sound = value
  when 'set'
    value = get_value instruction[2]
    @registers[instruction[1]] = value
  when 'add'
    value = get_value instruction[2]
    @registers[instruction[1]] += value
  when 'mul'
    value = get_value instruction[2]
    @registers[instruction[1]] *= value
  when 'mod'
    value = get_value instruction[2]
    @registers[instruction[1]] %= value
  when 'rcv'
    value = get_value instruction[1]
    if value != 0
      puts last_sound
      break
    end
  when 'jgz'
    value = get_value instruction[1]
    if value != 0
      offset = get_value instruction[2]
    end
  end

  i += offset
  break if i < 0 || i >= instructions.length
end
