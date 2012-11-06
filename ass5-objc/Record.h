
#import "RObject.h"

//object type that gets used to store things in the hash
@interface Record : RObject
{
  RObject * key;
  RObject * value;
}

-(void)setKey:(RObject *)aKey;
-(RObject *)key;
-(void)setValue:(RObject *)aValue;
-(RObject *)value;

@end
