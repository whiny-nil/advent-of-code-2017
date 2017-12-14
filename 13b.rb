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


firewall_template = []
input = File.readlines(__dir__ + "/inputs/13.txt")
input.each do |row|
  index, depth = row.split(":").map(&:to_i)
  firewall_template[index] = Layer.new(depth)
end

ftd = Marshal.dump(firewall_template)

it = 0
@solved = false
until @solved do
  it += 1
  @solved = true
  firewall = Marshal.load(ftd)
  firewall.each { |layer| layer.tick if layer }
  ftd = Marshal.dump(firewall)

  firewall.length.times do |i|
    layer = firewall[i]

    if layer
      if layer.pos == 0
        @solved = false
        break
      end
    end

    firewall.each { |layer| layer.tick if layer }
  end

  puts it if it % 10_000 == 0
end

puts it
