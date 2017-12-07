# general algorithm:
#
# read file in as an array of lines
# for each line:
# if it is "at the top" (ie, has no ->)
#   find the line that has that symbol
#   replace the symbol with the weight
#   blank out the original line
# else
#   ignore it
#
# delete empty rows from the array
#
# scan file again
# if everything after the -> is all numbers
#   compare the numbers, see if they are all the same
#   if so, add them together, add them to the weight and replace it
#     and delete the arrow and everything after it
#   if not, figure out which one is different and what its difference is
# if not, skip it
#
# repeat the whole process
#


# modify original file to make it easier to work with
# change (weight) to (self_weight,stack_weight)
copy = File.read(__dir__ + '/inputs/7.txt')
copy.gsub! ')', ',0)'
File.open(__dir__ + '/inputs/7-working.txt', 'w') { |f| f.write copy }

i = 0

while i < 1 do
  # find all rows with "nothing on top", then substitute those into
  # to rows that are holding them
  scanner = File.readlines(__dir__ + '/inputs/7-working.txt')
  buffer = File.read(__dir__ + '/inputs/7-working.txt')

  scanner.each do |line|
    # ignore if "nothing on top", ie no "-> asdf, dsdg" in line
    unless line.match /->/
       # ie, nothing on top
      buffer.sub! line, ''
      # update the 'asdlkja' with the weights
      parts = line.split
      buffer.sub! parts[0], parts[1]
    end
  end

  File.open(__dir__ + '/inputs/mod.txt', 'w') { |f| f.write buffer }

  # find all rows which have all their substitutions
  # then, add up all the stacks and see if they are the same weight
  # if they are, add up those weights and update the line's 'stack_weight'
  # if they aren't, figure out which stack is different and return the
  # stack's 'self_weight' +/- the difference
  scanner = File.readlines(__dir__ + '/inputs/mod.txt')
  scanner.each do |line|
    # get the stuff "on top"
    parts = line.split ' -> '
    num_pairs = "#{parts[1]}"
    # skip if line is "unresolved", ie, still has 'aadsfa' in it
    unless num_pairs.match /a-z/
      num_pairs = num_pairs.gsub('(', '').sub(")\n", '').split('),').map{ |pair| pair.split(',').map(&:to_i)}
      puts num_pairs.inspect
      #   if nums.min == nums.max
      #     total = nums.reduce(&:+)
      #     t_and_w = parts[0].split
      #     tag = t_and_w[0]
      #     weight = t_and_w[1].sub('(', '').sub(')', '')
      #     modifiable.sub! line, "#{tag} (#{weight}, #{total})\n"
      #   else
      #     puts nums.max_by { |i| nums.count(i) }
      #     exit
      #   end
    end
  end

  #File.open(__dir__ + '/inputs/mod.txt', 'w') { |f| f.write modifiable }

  i += 1
end
