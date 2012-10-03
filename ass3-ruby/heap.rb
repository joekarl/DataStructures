
#Extension of Array class
#Exposes a sort method to handle sorting of the heap
class Array 
 
  #Sort a heap in ascending order 
  #(as described via the text)
  #
  #This method acts upon the heap's internal structure
  #So this means it is destructive to the heap input
  #
  #inputs: none
  #
  #outputs: none 
  def heapsort
    build_heap
    length.downto(2) do |i|
      swap! 0, i - 1
      @heap_size -= 1
      heapify_downward 1
    end
  end

  #define private methods....
  #private
  
  attr_accessor :heap_size
  
  #inplace swap method (Hooray for ruby compound assignment) 
  def swap!(a,b)
    self[a], self[b] = self[b], self[a]
  end

  #Build the heap topology in place
  #(as described via the text)
  #
  #This method acts upon the heap's internal structure
  #So this means it is destructive to the heap input
  #
  #inputs: none 
  #
  #outputs: none
  def build_heap
    @heap_size = length
    (length / 2).floor.downto(1) do |i| 
      heapify_downward i 
    end
  end

  #Heapify Downward
  #
  #Ensures that index i obeys the heap topology
  #or it modifies the heap to make index i obey the heap topology
  #
  #Assumes that nodes under index i are currently in a heap topology ****** very important
  #
  #inputs:
  #i - index to check/modify
  #
  #outputs: none
  def heapify_downward(i)
    #find the lowest node index that the node i could fall to
    end_node_index = find_end_of_node_path(i)
    
    #stash the value of node i for later
    start_node_value = self[i - 1] 

    #search for the eventual final index where node i will fall
    swap_node_index = search_path_for_insert_position(i, end_node_index, start_node_value)
 
    #Move all parent nodes from the swap node index, up one level
    traversing_node_index = swap_node_index 
    swap_node_value = self[traversing_node_index - 1]
    parent_value = self[parent_index(traversing_node_index) - 1]
    while traversing_node_index != i 
      traversing_node_index = parent_index(traversing_node_index)
      self[traversing_node_index - 1] = swap_node_value
      swap_node_value = parent_value
      parent_value = self[parent_index(traversing_node_index) - 1]
    end
   
    #finally set the swap node index value to be our initial value 
    self[swap_node_index - 1] = start_node_value 
  end

  #binary search along a node path
  #
  #inputs: 
  #start_node_index - index at the start of a path
  #end_node_index - index at the end of a path
  #key_value - value we are going to search for in the path
  #
  #outputs:
  #the position of the key_value --OR-- in this case the position that the
  #key value should be inserted at
  def search_path_for_insert_position(start_node_index, end_node_index, key_value)
   
    if start_node_index >= end_node_index
      return start_node_index
    end
    
    if parent_index(end_node_index) == start_node_index
      #if only two elements in the path
      #use the end one as the midpoint
      mid = end_node_index
    else
      #calculate the mid point of the path
      mid_advances = 0.5 * height_of_heap(start_node_index)
      mid = end_node_index
      mid_advances.floor.downto(1) do |i|
        mid = parent_index(mid)
      end
    end

    if self[mid - 1] > key_value
      search_path_for_insert_position(next_child_in_path(start_node_index, end_node_index), end_node_index, key_value)
    elsif self[mid - 1] < key_value
      search_path_for_insert_position(start_node_index, parent_index(mid), key_value)
    else
      #we've found the insert position 
      mid 
    end 
  end

  #find the index of the end node of the correct path for heapification
  #
  #inputs:
  #i - the starting node
  #
  #outputs:
  #the end of the supposed path
  def find_end_of_node_path(i)
    left_index = left_child_index(i)
    right_index = right_child_index(i)
   
    if left_index > @heap_size && right_index > @heap_size
      i
    elsif right_index > @heap_size
      left_index
    else
      max_child_index = -1
      left_child_value = self[left_index - 1]
      right_child_value = self[right_index - 1]
      if right_child_value && left_child_value > right_child_value
        max_child_index = left_index
      else
        max_child_index = right_index
      end
      find_end_of_node_path max_child_index
    end
  end

  #find the next child in a given path
  #
  #inputs:
  #start_node_index - start of path
  #end_node_index - end of path
  #
  #output:
  #the index of the next child in a given path
  def next_child_in_path(start_node_index, end_node_index)
    next_child = end_node_index
    while parent_index(end_node_index) != start_node_index
      end_node_index = parent_index(end_node_index)
      next_child = end_node_index
    end 
    next_child
  end

  def height_of_heap(i)
    height = 0
    start_index = @heap_size
    while start_index >= i
      height++
      start_index = parent_index(start_index)
    end
    height
  end

  #returns the index of the parent of a heap node  
  #(as described via the text)
  def parent_index(i)
    (i / 2).floor
  end
  
  #returns the index of the left child of a heap node
  #(as described via the text)
  def left_child_index(i)
    i * 2
  end

  #returns the index of the right child of a heap node
  #(as described via the text)
  def right_child_index(i)
    (i * 2) + 1
  end

end
