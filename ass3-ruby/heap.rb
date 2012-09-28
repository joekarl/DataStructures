
#Heap class that extends Array
#Exposes a sort method to handle sorting of the heap
class Heap < Array 
  attr_accessor :heap_size
 
  #inplace swap method (Hooray for ruby compound assignment) 
  def swap!(a,b)
    self[a], self[b] = self[b], self[a]
  end
  
  #Sort a heap in ascending order 
  #(as described via the text)
  #
  #This method acts upon the heap's internal structure
  #So this means it is destructive to the heap input
  #
  #inputs: none
  #
  #outputs: none 
  def sort
    build_heap
    length.downto(2) do |i|
      swap! 0, i - 1
      @heap_size -= 1
      heapify_downward 1
    end
  end

  #define private methods....
  private

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
  #(as described via the text)
  #(or in the text, Max_Heapify)
  #
  #Ensures that index i obeys the heap topology
  #or it modifies the heap to make index i obey the heap topology
  #
  #This method acts upon the heap's internal structure
  #So this means it is destructive to the heap input
  #
  #inputs:
  #i - index to check/modify
  #
  #outputs: none
  def heapify_downward(i)
    l = left_child_index(i)
    r = right_child_index(i)
    
    if l <= @heap_size and self[l - 1] > self[i - 1] 
      largest = l  
    else 
      largest = i
    end
    
    if r <= @heap_size and self[r - 1] > self[largest - 1] 
      largest = r  
    end
    
    if largest != i
      swap! i - 1, largest - 1
      heapify_downward largest
    end 
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
