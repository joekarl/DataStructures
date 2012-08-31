#import "RObject.h"
#import "DblLinkedListNode.h"

@interface DblLinkedList : RObject
{
  @private
  DblLinkedListNode *head;
  DblLinkedListNode *tail;
  DblLinkedListNode *current;
  unsigned long long length;
}

+(DblLinkedList *)mergeList:(DblLinkedList *)l1 withList:(DblLinkedList *)l2;
+(DblLinkedList *)rangeList:(DblLinkedList *)list 
                  fromIndex:(unsigned long long)start
                    toIndex:(unsigned long long)end;

-(void)add:(unsigned long long)value;
-(void)rewind;
-(void)fastForward;
-(void)increment;
-(DblLinkedListNode *)getNodeAtIndex:(unsigned long long)index;
-(void)printList;

-(DblLinkedListNode *)head;
-(DblLinkedListNode *)tail;
-(DblLinkedListNode *)current;
-(unsigned long long)length;

@end

