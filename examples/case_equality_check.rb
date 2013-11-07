require 'simplecheck'

include Simplecheck

# Class#=== -> Class#kind_of?
check( 1, Integer )

# Regexp#=== -> Regexp#match
check( 'aaabbb', /^aaa/ )

# Range#=== -> Range#include?
check( 1, 1..10 )

# Proc#=== -> Proc#call
check( 1, lambda{ |n|  n.odd? })

puts "All passed"
