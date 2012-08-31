#import "DblLinkedListNode.h"

@implementation DblLinkedListNode

-(id)initWithData:(unsigned long long)someData
{
  self = [super init];
  if (self)
  {
    data = someData;
  }
  return self;
}

-(DblLinkedListNode *)next
{
  return next;
}

-(void)setNext:(DblLinkedListNode *)aNode
{
  next = aNode;;
}

-(DblLinkedListNode *)prev
{
  return prev;
}

-(void)setPrev:(DblLinkedListNode *)aNode
{
  prev = aNode;;
}

-(unsigned long long)data
{
  return data;
}

@end
