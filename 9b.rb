@input = File.read(__dir__ + "/inputs/9.txt")

@total = 0
@ignore_next_char = false
@inside_garbage = false
@group_level = 0
@garbage_count = 0

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
    if @inside_garbage
      @garbage_count += 1
    else
      start_group
    end
  when '}'
    if @inside_garbage
      @garbage_count += 1
    else
      close_group
    end
  when '<'
    if @inside_garbage
      @garbage_count += 1
    end
    @inside_garbage = true
  when '>'
    @inside_garbage = false
  when '!'
    @ignore_next_char = true
  else
    @garbage_count += 1 if @inside_garbage
  end
end

puts @garbage_count
