# Given an input, sum all numbers that match the following number.
# For the last number, see if it matches the first

def check_num(input)
  input = input.to_s
  num_of_checks = input.length

  # stick the first number on the end, so we don't need to worry about
  # looping back
  input = input + input[0]

  memo = 0
  num_of_checks.times do |i|
    memo = memo + input[i].to_i if input[i] == input[i+1]
  end

  memo
end


n1 = 1122
n2 = 1111
n3 = 1234
n4 = 91212129
n5 = File.read(__dir__ + '/inputs/1.txt').strip

[n1, n2, n3, n4, n5].each do |n|
  puts "#{n.to_s[0..4]}: #{check_num(n)}"
end
