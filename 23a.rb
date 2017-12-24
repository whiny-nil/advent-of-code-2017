@debug = ENV['DEBUG'] == 'true'

instructions = File.readlines(__dir__ + "/inputs/23.txt").map(&:strip).map(&:split)
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


mults = 0
loop do
  offset = 1
  instruction = instructions[i]
  puts instruction.inspect if @debug

  case instruction[0]
  when 'set'
    value = get_value instruction[2]
    @registers[instruction[1]] = value
  when 'sub'
    value = get_value instruction[2]
    @registers[instruction[1]] -= value
  when 'mul'
    value = get_value instruction[2]
    @registers[instruction[1]] *= value
    mults += 1
  when 'jnz'
    value = get_value instruction[1]
    if value != 0
      offset = get_value instruction[2]
    end
  end

  i += offset

  puts @registers.inspect if @debug
  puts i if @debug
  puts if @debug

  break if i < 0 || i >= instructions.length
end

puts mults
