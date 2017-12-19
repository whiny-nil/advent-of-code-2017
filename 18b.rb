class Program
  attr_reader :stopped, :waiting, :messages_sent, :queue

  def initialize(id)
    @id = id
    @registers = Hash.new 0
    @registers['p'] = id

    @instructions = File.readlines(__dir__ + "/inputs/18.txt").map(&:strip).map(&:split)
    #@instructions = File.readlines(__dir__ + "/inputs/18-test.txt").map(&:strip).map(&:split)
    @i = 0

    @queue = []

    @messages_sent = 0

    @waiting = false
    @stopped = false
  end

  def receiver=(program)
    @receiver = program
  end

  def get_value(x)
    if x.match /[a-z]/
      @registers[x]
    else
      x.to_i
    end
  end

  def tick
    return if @stopped
    offset = 1
    instruction = @instructions[@i]

    case instruction[0]
    when 'set'
      value = get_value instruction[2]
      @registers[instruction[1]] = value
    when 'add'
      value = get_value instruction[2]
      @registers[instruction[1]] += value
    when 'mul'
      value = get_value instruction[2]
      @registers[instruction[1]] *= value
    when 'mod'
      value = get_value instruction[2]
      @registers[instruction[1]] %= value
    when 'snd'
      value = get_value instruction[1]
      @receiver.queue.push value
      @messages_sent +=1
    when 'rcv'
      if @queue.length > 0
        value = @queue.shift
        @registers[instruction[1]] = value
        @waiting = false
      else
        offset = 0
        @waiting = true
      end
    when 'jgz'
      value = get_value instruction[1]
      if value > 0
        offset = get_value instruction[2]
      end
    end

    @i += offset
    @stopped = @i < 0 || @i >= @instructions.length
  end
end

p0 = Program.new 0
p1 = Program.new 1
p0.receiver = p1
p1.receiver = p0

until (p0.stopped || p0.waiting) && (p1.stopped || p1.waiting) do
  p0.tick
  p1.tick
end

puts p1.messages_sent
