class Layer
  attr_reader :depth, :scanner, :dir

  def initialize(depth)
    @depth = depth
    @scanner = Array.new depth
    @scanner[0] = 'X'
    @dir = -1
  end

  def pos
    @scanner.find_index 'X'
  end

  def tick
    @scanner.rotate!(dir)

    if @scanner[-1] == 'X'
      @dir = 1
    end

    if @scanner[0] == 'X'
      @dir = -1
    end
  end
end


firewall = []
input = File.readlines(__dir__ + "/inputs/13.txt")
input.each do |row|
  index, depth = row.split(":").map(&:to_i)
  firewall[index] = Layer.new(depth)
end

severity = 0

firewall.length.times do |i|
  pos = i
  layer = firewall[i]

  if layer
    severity += pos * layer.depth if layer.pos == 0
  end

  firewall.each { |layer| layer.tick if layer }
end

puts severity
