input = File.read(__dir__ + '/inputs/11.txt').strip.split(',')

@steps = {
  'n' => 0,
  's' => 0,
  'ne' => 0,
  'nw' => 0,
  'se' => 0,
  'sw' => 0,
}

input.each { |step| @steps[step] += 1 }

def cancel(a, b)
  min = [@steps[a], @steps[b]].min
  @steps[a] -= min
  @steps[b] -= min

  min
end

done = false
old_length = 0
new_length = 0

until done do

  cancel 'n', 's'
  cancel 'ne', 'sw'
  cancel 'se', 'nw'

  @steps['nw'] += cancel 'n', 'sw'
  @steps['sw'] += cancel 's', 'nw'
  @steps['ne'] += cancel 'n', 'se'
  @steps['se'] += cancel 's', 'ne'
  @steps['n'] += cancel 'ne', 'nw'
  @steps['s'] += cancel 'se', 'sw'

  old_length = new_length
  new_length = @steps.values.reduce(&:+)

  done = old_length == new_length
end

puts new_length
