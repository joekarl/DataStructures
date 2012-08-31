#import "RObject.h"

@interface DblLinkedListNode : RObject
{
  DblLinkedListNode *next;
  DblLinkedListNode *prev;
  unsigned long long data;
}

-(id)initWithData:(unsigned long long)someData;
-(DblLinkedListNode *)next;
-(void)setNext:(DblLinkedListNode *)aNode;
-(DblLinkedListNode *)prev;
-(void)setPrev:(DblLinkedListNode *)aNode;
-(unsigned long long)data;

@end
