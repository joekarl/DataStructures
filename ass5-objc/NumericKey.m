#import "NumericKey.h"

@implementation NumericKey

-(id)initWithValue:(int)value
{
  self = [super self];
  if (self)
  {
    _value = value;
  }
  return self;
}

-(int)value
{
  return _value;
}

-(long)hash
{
  return _value;
}

@end
