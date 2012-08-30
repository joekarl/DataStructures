@import <Foundation/Foundation.j>
@import "DblLinkedListNode.j"

@implementation DblLinkedList : CPObject
{
  DblLinkedListNode head;
  DblLinkedListNode current;
  DblLinkedListNode tail;
  CPNumber length;
}

-(id)init
{
  var self = [super init];
  if (self)
  {
    length = 0;
    head = nil;
    tail = nil;
    current = nil; 
  }
  return self;
}

-(void)addNodeWithData:(CPNumber)data
{
  var node = [[DblLinkedListNode alloc] initWithData:data prev:current next:nil];
  if (current) current.next = node;
  current = node;
  tail = node;
  length++;
  if (!head) {
    head = node;
  }
}

-(void)rewind
{
  current = head;
}

-(void)fastForward
{
  current = tail;
}

-(void)increment
{
  if (current) current = current.next;
}

-(DblLinkedListNode)getNodeAtIndex:(CPNumber)index
{
  if (index == 0) 
  {
    return head;
  } 
  else if (index == length - 1)
  {
    return tail;
  } 
  var node = head;
  var i = 0;
  while (i != index)
  {
    node = node.next;
    i++;
    if (!node) return;
  }
  return node;
}

-(CPString)description
{
  var curr = current;
  [self rewind];
  var i = 0;
  var desc = @"[";
  var separator = @", ";
  for (var i = 0; i < length; ++i)
  {
    var currentSeparator = (i == (length - 1)) ? @"" : separator;
    desc = [desc stringByAppendingFormat:@"%@%@", current, currentSeparator];
    [self increment];
  }
  desc = [desc stringByAppendingString:@"]"];
  current = curr;
  return desc;
}

+(DblLinkedList)listByMergingList:(DblLinkedList)l1 withList:(DblLinkedList)l2
{
  var newList = [[DblLinkedList alloc] init];
  [l1 rewind];
  [l2 rewind];

  while (l1.current && l2.current)
  {
    if (l1.current.data == l2.current.data) 
    {
      [newList addNodeWithData:l1.current.data];
      [l1 increment];
      [l2 increment];
    }
    else if (l1.current.data < l2.current.data)
    {
      [newList addNodeWithData:l1.current.data];
      [l1 increment];
    } 
    else
    {
      [newList addNodeWithData:l2.current.data];
      [l2 increment];
    }
  }

  while (l1.current)
  {
    [newList addNodeWithData:l1.current.data];
    [l1 increment];
  }
  while (l2.current)
  {
    [newList addNodeWithData:l2.current.data];
    [l2 increment];
  }

  return newList;
}

+(DblLinkedList)rangeList:(DblLinkedList)list fromIndex:(CPNumber)start toIndex:(CPNumber)end
{
  var i = 0;
  var newList = [[DblLinkedList alloc] init];
  [list rewind];
  while(list.current && i < end) {
    if (i >= start) {
      [newList addNodeWithData:list.current.data];
    }
    i++;
    [list increment];
  }
  return newList; 
}

@end
