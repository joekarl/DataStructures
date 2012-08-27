load('linkedList.js');
load('assert.js');

println('Test create list');
var list = new LinkedList();
assert(list.current == undefined, 'List current should be undefined');
assert(list.head == undefined, 'List head should be undefined');
assert(list.tail == undefined, 'List tail should be undefined');

println('\nTest add to list');
list.add('test');
assert(list.current.data == 'test','Should set current to first element on first insert');
assert(list.head.data == 'test','Should set head to first element on first insert');
assert(list.tail.data == 'test','Should set tail to first element on first insert');

println('\nTest add another to list');
list.add('test2');
assert(list.current.data == 'test','Should not change current on insert');
assert(list.head.data == 'test','Should not change head on insert');
assert(list.tail.data == 'test2','Should change tail to end of list');

println('\nTest add to middle of the list');
var initialLength = list.length;
list.add('test1.5',1);
assert(list.head.data == 'test','Should not change had on insert into middle of list');
assert(list.tail.data == 'test2','Should not change tail on insert into middle of list');
assert(list.length == initialLength + 1,'Should update length');
assert(list.get(1).data == 'test1.5','Should return test1.5 at index 1');

println('\nTest add to beginning of list');
initialLength = list.length;
list.add('test0',0);
assert(list.head.data == 'test0','Should set head of list');
assert(list.length == initialLength + 1, 'Should increment list length');

println('\nTest add to end of list');
initialLength = list.length;
list.add('test3',list.length);
assert(list.tail.data = 'test3','Should set tail of list');
assert(list.length == initialLength + 1,'Should increment list length');

println('\nTest get index 0');
var head = list.get(0);
assert(head == list.head,'Should return head');

println('\nTest get index list length');
var tail = list.get(list.length - 1);
assert(tail == list.tail,'Should return tail');

