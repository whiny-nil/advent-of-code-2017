# Given an input, sum all numbers that match the number "halfway" around.
# IE, if the length of the number is 10, match the number 5 steps away

def check_num(input)
  input = input.to_s
  num_of_checks = input.length
  step_size = input.length / 2

  # stick the number on itself so we don't need to worry about looping back
  input = input + input

  memo = 0
  num_of_checks.times do |i|
    memo = memo + input[i].to_i if input[i] == input[i+step_size]
  end

  memo
end


n1 = 1212
n2 = 1221
n3 = 123425
n4 = 123123
n5 = 12131415
n6 = File.read(__dir__ + '/inputs/1.txt').strip

[n1, n2, n3, n4, n5, n6].each do |n|
  puts "#{n.to_s[0..4]}: #{check_num(n)}"
end
