#import "RObject.h"

//class to hold numbers inside of classes
@interface NumericKey : RObject
{
  int _value;
}

-(id)initWithValue:(int)value;
-(int)value;

@end

