#input = [0,1,2,3,4]
#lengths = [3,4,1,5]
input = (0..255).to_a
lengths = File.read(__dir__ + "/inputs/10.txt").strip
#lengths = ""
lengths = lengths.bytes
lengths = lengths + [17, 31, 73, 47, 23]

current_position = 0
skip_size = 0

64.times do
  lengths.each do |length|
    next if length > input.length

    input = input.rotate current_position
    part_a = input.slice(0...length).reverse
    part_b = input.slice(length..-1)
    input = part_a + part_b
    input = input.rotate -current_position
    current_position = (current_position + length + skip_size) % input.length
    skip_size += 1
  end
end

sparse_hash = input
dense_hash = []

16.times do
  dense_hash << sparse_hash.shift(16).reduce(&:^).to_s(16)
end

puts dense_hash.join
