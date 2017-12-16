class Generator
  attr_accessor :factor, :previous_value

  def initialize(start, factor)
    @previous_value = start
    @factor = factor
  end

  def value
    @previous_value = (previous_value * factor) % divisor
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
#gen_a = Generator.new 65, 16_807
#gen_b = Generator.new 8_921, 48_271

# real
gen_a = Generator.new 277, 16_807
gen_b = Generator.new 349, 48_271

matches = 0
40_000_000.times do |i|
  matches +=1 if gen_a.binary_value[-16..-1] == gen_b.binary_value[-16..-1]
  puts i if i % 1_000_000 == 0
end

puts matches
