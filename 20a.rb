class Particle
  attr_reader :distance, :delta_distance

  def initialize(id, args)
    @id = id

    @px = args[0]
    @py = args[1]
    @pz = args[2]

    @vx = args[3]
    @vy = args[4]
    @vz = args[5]

    @ax = args[6]
    @ay = args[7]
    @az = args[8]

    @distance = nil
    @previous_distance = nil
    @delta_distance = nil

    calc_distance
  end

  def tick
    @vx += @ax
    @vy += @ay
    @vz += @vz

    @px += @vx
    @py += @vy
    @pz += @vz

    calc_distance
  end

  def calc_distance
    @previous_distance = @distance
    @distance = @px.abs + @py.abs + @pz.abs

    if @previous_distance == nil
      @delta_distance = nil
    else
      @delta_distance = @distance - @previous_distance
    end
  end

  def acceleration
    @ax.abs + @ay.abs + @az.abs
  end

  def <=>(other)
    #if (self.delta_distance <=> other.delta_distance) == 0
    #  self.distance <=> other.distance
    #else
    #  self.delta_distance <=> other.delta_distance
    #end

    self.acceleration <=> other.acceleration
  end
end

input = File.readlines(__dir__ + '/inputs/20.txt').map do |row|
  row = row.gsub /[^0-9\-,]/, ''
  row = row.split(',')
  row.map(&:to_i)
end

particles = []
input.each_with_index do |row, i|
  particles << Particle.new(i, row)
end

particles = particles.sort

#100_000_000.times do
#  particles.each(&:tick)
#  particles = particles.sort
#end


puts particles[0].inspect
