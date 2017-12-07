valid = 0
phrases = File.read(__dir__ + "/inputs/4.txt").split("\n").map(&:strip)
phrases.each { |phrase| valid += 1 if phrase.split.length == phrase.split.map{ |w| w.split('').sort.join('')}.uniq.length}

puts valid
