
#import "RObject.h"
#import "Record.h"

/*
 *  Class to handle basic hash functions
 */

@interface Hash : RObject
{
  @protected
  int _capacity;
  Record ** _hashTable;
  Record * _nil_slot;
}

-(id)initWithCapacity:(int)capacity;
-(BOOL)insert:(RObject *)obj withKey:(RObject *)key;
-(RObject *)removeObjectWithKey:(RObject *)key;
-(RObject *)objectWithKey:(RObject *)key;

@end


