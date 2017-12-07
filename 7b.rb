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

input = File.readlines(__dir__ + '/inputs/7.txt')
modifiable = File.read(__dir__ + '/inputs/7.txt')
i = 0

while i < 1 do
  input.each do |line|
    unless line.match /->/
      modifiable.sub! line, ''
      line.sub! '(', ''
      line.sub! ')', ''
      parts = line.split
      modifiable.sub! parts[0], parts[1]
    end
  end

  File.open(__dir__ + '/inputs/mod.txt', 'w') { |f| f.write modifiable }

  input = File.readlines(__dir__ + '/inputs/mod.txt')
  input.each do |line|
    parts = line.split ' -> '
    nums = parts[1].split(',').map(&:to_i)
    unless nums.any? { |el| el == 0 }
      if nums.min == nums.max
        total = nums.reduce(&:+)
        t_and_w = parts[0].split
        tag = t_and_w[0]
        weight = t_and_w[1].sub('(', '').sub(')', '')
        modifiable.sub! line, "#{tag} (#{weight}, #{total})\n"
      else
        puts nums.max_by { |i| nums.count(i) }
        exit
      end
    end
  end

  File.open(__dir__ + '/inputs/mod.txt', 'w') { |f| f.write modifiable }

  i += 1
end
