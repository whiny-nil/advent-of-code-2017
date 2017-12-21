@input = File.read(__dir__ + "/inputs/9.txt")

@total = 0
@ignore_next_char = false
@inside_garbage = false
@group_level = 0

def start_group
  @group_level += 1
end

def close_group
  @total += @group_level
  @group_level -= 1
end

@input.each_char do |c|
  if @ignore_next_char
    @ignore_next_char = false
    next
  end

  case c
  when '{'
    start_group unless @inside_garbage
  when '}'
    close_group unless @inside_garbage
  when '<'
    @inside_garbage = true
  when '>'
    @inside_garbage = false
  when '!'
    @ignore_next_char = true
  else
    # ignore
  end
end

puts @total
