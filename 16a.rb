input = File.read(__dir__ + '/inputs/16.txt').strip.split(',')
steps = input.map { |s| [s[0], s[1..-1]] }

@dancers = []
16.times { |i| @dancers[i] = (i + 97).chr }

steps.each do |step|
  case step[0]
  when 's'
    @dancers = @dancers.rotate -step[1].to_i
  when 'x'
    pos_a, pos_b = step[1].split('/').map(&:to_i)
    a = @dancers[pos_a]
    b = @dancers[pos_b]
    @dancers[pos_a] = b
    @dancers[pos_b] = a
  when 'p'
    a, b = step[1].split('/').map(&:strip)
    pos_a = @dancers.index a
    pos_b = @dancers.index b
    @dancers[pos_a] = b
    @dancers[pos_b] = a
  end
end

puts @dancers.join
