input = File.readlines(__dir__ + "/inputs/12.txt").map { |n| n.split(" <-> ") }
@nodes = {}
input.each { |n| @nodes[n[0].to_i] = n[1].split(',').map(&:to_i) }

def get_all_nodes(node, skip = nil)
  found_nodes = [node]
  @nodes[node].each do |n|
    found_nodes += get_all_nodes(n, node) unless n == skip
  end

  found_nodes.compact.uniq.sort
end

groups = 0
while !@nodes.empty?
  groups += 1
  my_nodes = get_all_nodes(@nodes.first[0])
  my_nodes.each { |n| @nodes.delete n }
end

puts groups
