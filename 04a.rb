valid = 0
phrases = File.read(__dir__ + "/inputs/4.txt").split("\n").map(&:strip)
phrases.each { |phrase| valid += 1 if phrase.split.length == phrase.split.uniq.length}

puts valid
