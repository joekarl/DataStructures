require 'binary_search_tree'
require 'merge_sort'
require 'enumerator'

#keys array
keys = []

#ask how many keys the user should input
puts "How many keys do you want to input?"
key_num = nil
init = true
while not key_num.is_a? Numeric
  if not init 
    puts "Invalid number"
    puts "How many keys do you want to input?"
  else
    init = false
  end
  key_num = gets.chomp
  key_num = key_num.to_i if Integer(key_num) rescue false
end
puts "" 

#populate keys with user input
(0...key_num).each do |i|
  puts "Input integer key(#{i})"
  key = nil
  init = true
  while not key.is_a? Numeric
    if not init 
      puts "Invalid number"
      puts "Input integer key(#{i})"
    else
      init = false
    end
    key = gets.chomp
    key = key.to_i if Integer(key) rescue false
  end
  keys[i] = key
end
puts ""

#sort keys in O(n lg n) time if not already sorted...
sorted = true
#k so this line is weird but concise,
#basically, we compare each consecutive entry in the keys array
#and we record whether or not we're still sorted
#if at the end we're still sorted, then we're sorted
#takes O(n) time
keys.each_cons(2) {|a,b| sorted = ((a <=> b) <= 0) if sorted}
if sorted
  puts "Not sorting keys becuase already sorted...."
else
  puts "Sorting keys"
  keys = mergesort keys 
end

#construct subtree in O(n) time
puts "Building BST"
tree = BinarySearchTree.sorted_array_to_bst(keys)

#print out tree in sorted order
puts "Ordered keys via inorder traversal"
print_key = lambda {|key| print "#{key} "}
tree.inorder_traversal print_key
puts ""



