@nodes = File.readlines(__dir__ + "/inputs/12.txt").map do |n|
  n.split(">")[1] # the node becomes the key, so get the connections
    .split(',')
    .map { |n| n.to_i }
end

def get_all_nodes(node, skip = nil)
  found_nodes = [node]
  @nodes[node].each do |n|
    found_nodes += get_all_nodes(n, node) unless n == skip
  end

  found_nodes.compact.uniq.sort
end

my_nodes = get_all_nodes(0)

puts [my_nodes.count, my_nodes].inspect
