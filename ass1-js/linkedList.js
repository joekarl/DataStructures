//linked list implementation

//node constructor
LinkedListNode = function(data,prev,next) {
  this.prev = prev;
  this.next = next;
  this.data = data;
};

//tostring for node
LinkedListNode.prototype = {
  toString: function() {
    return this.data;
  }
};

//linked list constructor
LinkedList = function() {
  this.length = 0;
  this.head;
  this.current;
  this.tail;
};

//non-destructive merge list function
//assumes that lists are sorted in ascending order
//eliminates duplicates
LinkedList.mergeLists = function(l1,l2) {
  var newList = new LinkedList();

  l1.rewind();
  l2.rewind();

  while (l1.current && l2.current) {
    if (l1.current.data == l2.current.data) {
      newList.add(l1.current.data);
      l1.advance();
      l2.advance();
    } else if (l1.current.data < l2.current.data) {
      newList.add(l1.current.data);
      l1.advance();
    } else {
      newList.add(l2.current.data);
      l2.advance();
    }
  }

  while (l1.current) {
    newList.add(l1.current.data);
    l1.advance();
  }

  while (l2.current) {
    newList.add(l2.current.data);
    l2.advance();
  }

  return newList;
};

//return a list that encompasses the given range
LinkedList.range = function(list, start, end) {
  var i = 0;
  var newList = new LinkedList();
  list.rewind();
  while(list.current && i < end) {
    if (i >= start) {
      newList.add(list.current.data);
    }
    i++;
    list.advance();
  }
  return newList;
};

//Linked List instance methods
LinkedList.prototype = {
  //create and add a new node
  //handles initializing the list if needed
  //handles adding data at a specific index
  //by default, adds node to the end of the list
  add: function(data,index) {
    this.rewind();
    var node = new LinkedListNode(data);
    if (typeof this.head == 'undefined') {
      this.head = node;
      this.tail = node
      this.length++;
      this.current = node;
      return true;
    } else if (typeof index == 'number' && index != this.length) {
      //for traversal
      var tNode = this.head;
      var i = 0;
      while (tNode && i != index) {
        tNode = tNode.next;
        i++;
      }
      if (tNode) {
        var prev = tNode.prev;
        if (prev) {
          prev.next = node;
          node.prev = prev;
        } else {
          this.head = node;
        }
        node.next = tNode;
        tNode.prev = node;
        this.length++;
        return true;
      } else {
        return false;
      }
    } else {
      this.fastForward();
      this.current.next = node;
      node.prev = this.current;
      this.tail = node;
      this.length++;
      return true;
    }
  },
  //return the node at a given index
  get: function(index) {
    //handle head case and tail case
    if (index == 0) {
      return this.head;
    } else if (index == this.length - 1) {
      return this.tail;
    }
    var tNode = this.head;
    var i = 0;
    while(i != index) {
      tNode = tNode.next;
      i++;
      if (!tNode) return;
    }
    return tNode;
  },
  //move the current list node to be the next list node
  advance: function() {
    if (this.current) {
      this.current = this.current.next;
    }
  },
  //move the current list node to the head of the list
  rewind: function() {
    this.current = this.head;
  },
  //move the current list node to the end of the list
  fastForward: function() {
    this.current = this.tail;
  },
  //remove all nodes from the list and reset the length
  reset: function() {
    this.current = undefined;
    this.head = undefined;
    this.tail = undefined;
    this.length = 0;
  },
  //print the list
  toString: function() {
    this.rewind();
    var str = "";
    str += '[';
    while(this.current) {
      str += this.current.data;
      if (this.current != this.tail) {
        str += ', ';
      }
      this.advance();
    }
    str +=']\n';
    return str;
  }
};

