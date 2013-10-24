require 'simplecheck'
include Simplecheck

# Block passed implicitly to check
check( 2, 4 ){ |x, y| x + y > 5 }

# Block passed explicity to check
sum_check = lambda{ |x, y| x + y > 5 } 
check( 2, 4, &sum_check )

puts "All passed"
