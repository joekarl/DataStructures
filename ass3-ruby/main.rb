require "heap.rb"
require 'test/unit'

a = [5,13,2,25,7,17,20,8,4]

puts "Array starts as #{a.inspect}"

a.heapsort

puts "And after sort #{a.inspect}"

puts "------------------------------------------------------------------------------"

#a = [52,25,12,3,4,76,4,23,6,8,9,6,3,23,23,54,56,6,8,9,54,34,34,89,43,13,2,25,7,17,20,8,4,234,6,4,2,5,7,9,5,3,2,4,6,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,23,3,4,5,6,7,8,9]
#a = [52,25,12,3,4,76,4,23,6,8,9,6,3,23,23,54,56,6,8,9,54,34,34,89,43,13,2,25,7,17,20,8,4]
#a = [1,2,3,4,5,6,7,1,2,3,4,5,6,7,8,9]
#a = [1,2,3,4,5,6,7,1,2,3,4,5,6,7,8,9]
#a = [4,9,2,1]

class TestHeapsort < Test::Unit::TestCase
  def test_heapsort
    (0..1000).each do |x|
      puts "Testing permutation #{x + 1}"
      a = []
      seed = srand()
      (0..100).each {|i| a[i] = rand(seed) % 1000}

      copy_a = a
      a.heapsort

      failed = false
      last = a[0]
      a.each do |val|
        failed = true if val < last
        last = val
      end

      assert !failed, "Failed to sort array #{copy_a.inspect} and ended with #{a.inspect}"
    end
  end
end
