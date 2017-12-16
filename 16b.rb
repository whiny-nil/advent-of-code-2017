@dancers = []
16.times { |i| @dancers[i] = (i + 97).chr }

input = File.read(__dir__ + '/inputs/16.txt').strip.split(',')

@steps = input.map { |s| [s[0], s[1..-1]] }
@steps.each_with_index do |step, i|
  @steps[i][1] = case step[0]
                   when 's' then -step[1].to_i
                   when 'x' then step[1].split('/').map(&:to_i)
                   when 'p' then step[1].split('/').map(&:strip)
                 end
end

@swap = Proc.new { |i| @dancers.rotate! i }
@exchange = Proc.new { |args|
  a = @dancers[args[0]]
  @dancers[args[0]] = @dancers[args[1]]
  @dancers[args[1]] = a
}
@partner = Proc.new { |args|
  pos_a = @dancers.index args[0]
  pos_b = @dancers.index args[1]
  @dancers[pos_a] = args[1]
  @dancers[pos_b] = args[0]
}

@cycle = [@dancers.join]
loop do
  @steps.each do |step|
    case step[0]
    when 's'
      @swap.call(step[1])
    when 'x'
      @exchange.call(step[1])
    when 'p'
      @partner.call(step[1])
    end
  end

  dancers = @dancers.join
  x = @cycle.index dancers

  if x.nil?
    @cycle << dancers
  else
    puts x
    break
  end
end

puts @cycle[1_000_000_000 % 60]
