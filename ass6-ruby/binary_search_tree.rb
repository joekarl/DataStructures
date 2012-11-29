# binary search tree class
# defines the data structure for the tree node
# also defines convenience method to build a binary search tree
# and also provides an inorder traversal method
class BinarySearchTree
  # ivars
  attr_accessor :left_child, :right_child, :parent, :key

  # make a bst from a sorted array
  # this takes O(n) time
  # returns the root of a height balanced binary search tree
  def self.sorted_array_to_bst(array = [], start_index = 0, end_index = array.length)
    return nil if (start_index > end_index) 
    
    mid = (start_index + end_index) / 2
    parent = BinarySearchTree.new
    parent.key = array[mid]
    parent.left_child = BinarySearchTree.sorted_array_to_bst(array, start_index, mid - 1)
    parent.right_child = BinarySearchTree.sorted_array_to_bst(array,  mid + 1, end_index)
    return parent
  end

  # inorder traversal
  # on_traverse is a block which will be called during traversal
  # the on_traverse block will be passed the current key when called
  def inorder_traversal (on_traverse) 
    @left_child.inorder_traversal(on_traverse) if @left_child
    on_traverse.call(@key) 
    @right_child.inorder_traversal(on_traverse) if @right_child
  end

end
