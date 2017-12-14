def knot_hash(input)
  input_bytes = input.bytes
  # salt input_bytes
  input_bytes = input_bytes + [17, 31, 73, 47, 23]

  current_position = 0
  skip_size = 0
  sparse_hash = (0..255).to_a

  64.times do
    input_bytes.each do |byte|
      next if byte > sparse_hash.length

      sparse_hash = sparse_hash.rotate current_position

      part_a = sparse_hash.slice(0...byte).reverse
      part_b = sparse_hash.slice(byte..-1)
      sparse_hash = part_a + part_b

      sparse_hash = sparse_hash.rotate -current_position
      current_position = (current_position + byte + skip_size) % sparse_hash.length

      skip_size += 1
    end
  end

  dense_hash = []

  16.times do
    dense_hash << sparse_hash.shift(16).reduce(&:^).to_s(16).rjust(2, "0")
  end

  dense_hash.join
end

#puts knot_hash(File.read(__dir__ + "/inputs/10.txt").strip)

#seed = "flqrgnkx"
seed = "stpzcrnm"

@memory = []

128.times do |i|
  hash = knot_hash("#{seed}-#{i}")
  bits = hash.each_char.map { |c| "%04b" % c.to_i(16) }.join.gsub("1", "x").split("")
  @memory << bits
end

def mark_region(x, y, region)
  begin
    @memory[x][y] = region
    mark_region x-1, y, region if x > 0 && @memory[x-1][y] == 'x'
    mark_region x+1, y, region if x < @memory.length-1 && @memory[x+1][y] == 'x'
    mark_region x, y-1, region if y > 0 && @memory[x][y-1] == 'x'
    mark_region x, y+1, region if y < @memory[x].length-1 && @memory[x][y+1] == 'x'
  rescue StandardError => e
    puts [x, y, region].inspect
    raise e
  end
end

regions = 0
@memory.length.times do |x|
  row = @memory[x]
  row.length.times do |y|
    if @memory[x][y] == "x"
      regions += 1
      mark_region x, y, regions
    end
  end
end

puts regions
