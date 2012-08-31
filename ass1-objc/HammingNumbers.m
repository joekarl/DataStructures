#import "HammingNumbers.h"

@interface HammingNumbers (pvt)
+(BOOL)doneGeneratingTermsForList:(DblLinkedList *)final 
                     withTempList:(DblLinkedList *)tempList
                forSequenceLength:(int)n; 

+(DblLinkedList *)generateTermsFromList:(DblLinkedList *)list
                         withMultiplier:(unsigned long long)m;
@end

@implementation HammingNumbers (pvt)
+(BOOL)doneGeneratingTermsForList:(DblLinkedList *)final 
                     withTempList:(DblLinkedList *)tempList
                forSequenceLength:(int)n
{
  [tempList rewind];
  unsigned long long minTerm = [[tempList current] data];

  return [final length] >= n 
          && [[final getNodeAtIndex:(n - 1)] data] <= minTerm;
}

+(DblLinkedList *)generateTermsFromList:(DblLinkedList *)list
                         withMultiplier:(unsigned long long)m
{
  id termList = [DblLinkedList new];

  [list rewind];
  while([list current])
  {
    [termList add:([[list current] data] * m)];
    [list increment];
  }

  return termList;
}

@end

@implementation HammingNumbers

+(DblLinkedList *)generateSequenceWithLength:(int)n
{
  id final = [DblLinkedList new];
  id temp = [DblLinkedList new];
  id l2;
  id l3;
  id l5;

  [temp add:2];
  [temp add:3];
  [temp add:5];

  while(![HammingNumbers doneGeneratingTermsForList:final withTempList:temp forSequenceLength:n])
  {
    id finalPtr = final;
    final = [DblLinkedList mergeList:final withList:temp];
    [finalPtr release];
    finalPtr = nil;

    l2 = [HammingNumbers generateTermsFromList:temp withMultiplier:2];
    l3 = [HammingNumbers generateTermsFromList:temp withMultiplier:3];
    l5 = [HammingNumbers generateTermsFromList:temp withMultiplier:5];

    id tempPtr = temp;
    temp = [DblLinkedList mergeList:l2 withList:l3];
    [tempPtr release];
    
    tempPtr = temp;
    temp = [DblLinkedList mergeList:l5 withList:temp];
    [tempPtr release];
    tempPtr = nil;

    [l2 release];
    [l3 release];
    [l5 release];

    l2 = nil;
    l3 = nil;
    l5 = nil;
  }
 
  [temp release];
  temp = nil;
  
  id finalPtr = final;
  final = [DblLinkedList rangeList:final fromIndex:0 toIndex:n];
  [finalPtr release];

  return final;
}

@end

