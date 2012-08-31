#import "DblLinkedList.h"

@implementation DblLinkedList

+(DblLinkedList *)mergeList:(DblLinkedList *)l1 withList:(DblLinkedList *)l2
{
  id merged_list = [[DblLinkedList alloc] init];

  [l1 rewind];
  [l2 rewind];
  
  //merge shared list indices
  while([l1 current] && [l2 current])
  {
    if ([[l1 current] data] == [[l2 current] data])
    {
      [merged_list add:[[l1 current] data] ];
      [l1 increment];
      [l2 increment];
    } 
    else if ([[l1 current] data] < [[l2 current] data])
    {
      [merged_list add:[[l1 current] data] ];
      [l1 increment];
    } 
    else
    {
      [merged_list add:[[l2 current] data] ];
      [l2 increment];
    }
  }

  //merge any leftover nodes
  while(l1->current)
  {
    [merged_list add:[[l1 current] data] ];
    [l1 increment];
  }
  
  while(l2->current)
  { 
    [merged_list add:[[l2 current] data] ];
    [l2 increment]; 
  }

  return merged_list;
}

+(DblLinkedList *)rangeList:(DblLinkedList *)list 
                  fromIndex:(unsigned long long)start
                    toIndex:(unsigned long long)end
{
  int i = 0;
  id range_list = [[DblLinkedList alloc] init];
  [list rewind];
  while([list current] && i < end)
  {
    if (i++ >= start)
    {
      [range_list add:[[list current] data] ];
    }
    [list increment];
  }
  return range_list;
}

-(void)add:(unsigned long long)value
{
  DblLinkedListNode *node = [[DblLinkedListNode alloc] initWithData:value];
  if (!head)
  {
    head = node;
    tail = node;
    current = node;
  }
  else
  {
    [tail setNext:node];
    [node setPrev:tail];
    tail = node;
  }
  length++;
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
  if (current) 
  {
    current = [current next];
  }
}

-(DblLinkedListNode *)getNodeAtIndex:(unsigned long long)index
{
  if (index == 0) return head;
  else if (index == length - 1) return tail;

  id node = head;
  unsigned long long i = 0;
  while (node && i != index)
  {
    node = [node next];
    i++;
  }
  return node;
}

-(void)printList
{
  printf("[");
  DblLinkedListNode *tCurrent = current;
  [self rewind];
  while(current){
    printf("%lld",[current data]);
    //print seperator if not last in the list
    if (current != tail) 
    {
      printf(", ");
    }
    [self increment];
  }
  printf("]");
  current = tCurrent;
}

-(DblLinkedListNode *)head
{
  return head;
}

-(DblLinkedListNode *)tail
{
  return tail;
}

-(DblLinkedListNode *)current
{
  return current;
}

-(unsigned long long)length
{
  return length;
}

-(void)dealloc
{
  [self rewind];
  while (current)
  {
    id node = current;
    current = [node next];
    [node release];
  }
  [super dealloc];
}

@end
