class Generator
  attr_accessor :factor, :previous_value, :filter

  def initialize(start, factor, filter)
    @previous_value = start
    @factor = factor
    @filter = filter
  end

  def value
    loop do
      @previous_value = (previous_value * factor) % divisor
      break if previous_value % filter == 0
    end

    previous_value
  end

  def binary_value
    value.to_s(2).rjust(16, "0")
  end

  private

  def divisor
    2_147_483_647
  end
end

# test
#gen_a = Generator.new 65, 16_807, 4
#gen_b = Generator.new 8_921, 48_271, 8

# real
gen_a = Generator.new 277, 16_807, 4
gen_b = Generator.new 349, 48_271, 8

#5.times do
#  puts [gen_a.binary_value[-16..-1], gen_b.binary_value[-16..-1]].inspect
#end


matches = 0
5_000_000.times do |i|
  matches +=1 if gen_a.binary_value[-16..-1] == gen_b.binary_value[-16..-1]
  puts i if i % 500_000 == 0
end

puts matches
