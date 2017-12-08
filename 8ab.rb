def parse_line(line)
  parts = line.split
  @target = parts[0]
  @operator = parts[1] == 'inc' ? :+ : :-
  @amount = parts[2].to_i
  # parts[3] == 'if'
  @condition_target = parts[4]
  @condition_operator = parts[5].to_sym
  @condition_amount = parts[6].to_i
end

input = File.readlines(__dir__ + '/inputs/8.txt')
registers = Hash.new(0)
max_at_any_point = 0

input.each do |line|
  parse_line line
  registers[@target] = registers[@target].send(@operator, @amount) if registers[@condition_target].send(@condition_operator, @condition_amount)
  max_at_any_point = registers[@target] if registers[@target] > max_at_any_point
end

puts [registers.values.max, max_at_any_point].inspect
