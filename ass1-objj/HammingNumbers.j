@import <Foundation/Foundation.j>
@import "DblLinkedList.j"

@implementation HammingNumbers : CPObject
{

}

+(BOOL)_haveEnoughTermsInList:(DblLinkedList)finalList withTempList:(DblLinkedList)tempList andSize:(CPNumber)size
{
  if (!tempList.current) return;
  [tempList rewind];
  var minTerm = tempList.current.data;
  [finalList rewind];
  var currentSize = 0;
  if (finalList.current)
  {
    while(finalList.current.data <= minTerm)
    {
      currentSize++;
      [finalList increment];
    }
  }
  print("Current final list size: " + currentSize + "\n");
  
  return finalList.length >= size
            && [finalList getNodeAtIndex:(size - 1)].data <= minTerm;
}

+(DblLinkedList)_generateTermsWithList:(DblLinkedList)list andMultiplier:(CPNumber)m
{
  var newList = [[DblLinkedList alloc] init];
  [list rewind];
  while (list.current)
  {
    [newList addNodeWithData:(list.current.data * m)];
    [list increment];
  }
  return newList;
}

+(DblLinkedList)generateSequenceWithLength:(CPNumber)n
{
  var finalSeq = [[DblLinkedList alloc] init];
  var temp = [[DblLinkedList alloc] init];
  var l2;
  var l3;
  var l5;

  [temp addNodeWithData:2];
  [temp addNodeWithData:3];
  [temp addNodeWithData:5];

  while(![self _haveEnoughTermsInList:finalSeq withTempList:temp andSize:n])
  {
    finalSeq = [DblLinkedList listByMergingList:finalSeq withList:temp];
    l2 = [HammingNumbers _generateTermsWithList:temp andMultiplier:2];
    l3 = [HammingNumbers _generateTermsWithList:temp andMultiplier:3];
    l5 = [HammingNumbers _generateTermsWithList:temp andMultiplier:5];

    temp = [DblLinkedList listByMergingList:[DblLinkedList listByMergingList:l2 withList:l3] withList:l5];
  }
  return [DblLinkedList rangeList:finalSeq fromIndex:0 toIndex:n];
}

@end
