steps = 355
# steps = 3
iterations = 50_000_000
# iterations = 9
current_position = 0
current_length = 1
number_after_zero = nil

(1..iterations).each do |i|
  steps_remaining = steps

  until steps_remaining == 0 do
    steps_to_start = current_length - current_position
    if steps_to_start > steps_remaining
      current_position += steps_remaining
      steps_remaining = 0
    else
      current_position = 0
      steps_remaining -= steps_to_start
    end
  end

  number_after_zero = i if current_position == 0
  current_position += 1
  current_length += 1

  puts i if i % 1_000_000 == 0
end

puts number_after_zero
