require "heap.rb"

a = [5,13,2,25,7,17,20,8,4]

puts "Array starts as #{a.inspect}"

a.heapsort

puts "And after sort #{a.inspect}"

puts "------------------------------------------------------------------------------"

a = [52,25,12,3,4,76,4,23,6,8,9,6,3,23,23,54,56,6,8,9,54,34,34,89,43,13,2,25,7,17,20,8,4]

puts "Array starts as #{a.inspect}"

a.heapsort

puts "And after sort #{a.inspect}"

