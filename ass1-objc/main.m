
#import "HammingNumbers.h"

int main()
{
  id seq = [HammingNumbers generateSequenceWithLength:4000];
  [seq printList];
  printf("\n");

  [seq release];
  return 0;
}

