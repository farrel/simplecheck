require 'simplecheck'

include Simplecheck

check(1.odd?)
check(5 > 2)
check([1, 2, 3].include?(2))

puts 'All passed'
