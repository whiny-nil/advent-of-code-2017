# Read a file.  Each row is split (by whitespace) into integers (so, file is a multi-dimentional array).
# For each line, compute (and store) the value of the two numbers that evenly divide each other
# Sum the comuted values to get a checksum.

def row_checksum(row)
  row = row.split
  row = row.map(&:to_i)
  row = row.sort

  row.length.times do
    numerator = row.pop

    row.each do |denominator|
      return numerator / denominator if numerator % denominator == 0
    end
  end
end

def array_checksum(array)
  rows = array.split("\n")
  rows = rows.map { |row| row_checksum(row) }

  rows.reduce(&:+)
end

a1 = "5 9 2 8
9 4 7 3
3 8 6 5"

a2 = File.read(__dir__ + '/inputs/2.txt')

puts array_checksum(a1)
puts array_checksum(a2)
