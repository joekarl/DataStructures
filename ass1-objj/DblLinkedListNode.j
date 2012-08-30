@import <Foundation/Foundation.j>

@implementation DblLinkedListNode : CPObject
{
  DblLinkedListNode prev;
  DblLinkedListNode next;
  DblLinkedListNode data;
}

-(id)initWithData:(CPNumber)someData prev:(DblLinkedListNode)aPrev next:(DblLinkedListNode)aNext
{
  var self = [super init];

  if (self) {
    data = someData;
    prev = aPrev;
    next = aNext;
  }

  return self;
}

-(CPString)description
{
  return data;
}

@end
