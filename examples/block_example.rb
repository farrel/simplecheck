require 'simplecheck'

include Simplecheck

# Block passed implicitly to check
check(2, 4) { |x| x.even? }

# Block passed explicity to check
is_even = ->(x) { x.even? }
check(2, 4, &is_even)

puts 'All passed'
