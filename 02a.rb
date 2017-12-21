# Read a file.  Each row is split (by whitespace) into integers (so, file is a multi-dimentional array).
# For each line, compute (and store) the value of the largest number - the smallest number.
# Sum the comuted values to get a checksum.

def row_checksum(row)
  row = row.split
  largest = 0
  smallest = 1000000000000000000000000000000000000000000
  row.each do |el|
    el = el.to_i
    largest = el if el > largest
    smallest = el if el < smallest
  end

  largest - smallest
end

def array_checksum(array)
  rows = array.split("\n")
  rows = rows.map { |row| row_checksum(row) }

  rows.reduce(&:+)
end

a1 = "5 1 9 5
7 5 3
2 4 6 8"

a2 = File.read(__dir__ + '/inputs/2.txt')

puts array_checksum(a1)
puts array_checksum(a2)
