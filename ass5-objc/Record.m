
#import "Record.h"

@implementation Record


-(id)init
{
  self = [super init];
  if (self)
  {
    key = 0;
    value = 0;
  }
  return self;
}

-(void)setKey:(RObject *)aKey
{
  if (aKey != key){
    id temp = key;
    key = aKey;
    [key retain];
    [temp release];
  }
}

-(RObject *)key
{
  return key;
}


-(void)setValue:(RObject *)aValue
{
  if (aValue != value){
    id temp = value;
    value = aValue;
    [value retain];
    [temp release];
  }
}

-(RObject *)value
{
  return value;
}

-(void)dealloc
{
  [key release];
  [value release];
  [super dealloc];
}

@end
