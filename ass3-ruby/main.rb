require "heap.rb"

a = Heap.new [5,13,2,25,7,17,20,8,4]

puts "Array starts as #{a.inspect}"

a.sort

puts "And after sort #{a.inspect}"

