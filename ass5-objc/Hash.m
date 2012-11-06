#import "Hash.h"
#import <stdlib.h>

@implementation Hash

//init with a capacity
-(id)initWithCapacity:(int)capacity
{
  self = [super init];
  if (self)
  {
    _capacity = capacity;
    _hashTable = calloc(capacity, sizeof(Record));    
    _nil_slot = [[Record alloc] init];
  }
  return self;
}

-(BOOL)insert:(RObject *)obj withKey:(RObject *)key;
{
  //must implement
  exit(-1);
}

-(RObject *)removeObjectWithKey:(RObject *)key;
{
  //must implement
  exit(-1);
}

-(RObject *)objectWithKey:(RObject *)key;
{
  //must implement
  exit(-1);
}

-(void)dealloc
{
  free(_hashTable);
  [super dealloc];
}

@end
