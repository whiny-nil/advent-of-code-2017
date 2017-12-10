#input = [0,1,2,3,4]
#lengths = [3,4,1,5]
input = (0..255).to_a
lengths = File.read( __dir__ + "/inputs/10.txt").split(',').map(&:to_i)

current_position = 0
skip_size = 0

lengths.each do |length|
  next if length > input.length

  input = input.rotate current_position
  part_a = input.slice(0...length).reverse
  part_b = input.slice(length..-1)
  input = part_a + part_b
  input = input.rotate -current_position
  current_position = (current_position + length + skip_size) % input.length
  skip_size += 1
  puts input.inspect
end

puts input[0] * input[1]
