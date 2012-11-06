
#import "LinearProbeHash.h"
#import <stdio.h>

@interface LinearProbeHash(pvt)

-(long)probeWithHash:(long)hash atDepth:(int)depth;

@end

@implementation LinearProbeHash(pvt)

-(long)probeWithHash:(long)hash atDepth:(int)depth
{
  return (hash + depth) % _capacity;
}

@end

@implementation LinearProbeHash

//insert an object with a key
//if insert fails it will return NO
//if it succeeds it will return YES
-(BOOL)insert:(RObject *)obj withKey:(RObject *)key;
{
  long hash = [key hash];
  int probe = 0;
  long slot = [self probeWithHash:hash atDepth:0];
  while ((slot < _capacity) && _hashTable[slot] && ![_nil_slot isEqual:_hashTable[slot] ])
  {
    _collisions++;
    slot = [self probeWithHash:hash atDepth:++probe];
  }
  if (slot >= _capacity)
  {
    return NO;
  }
  else
  {
    Record * newRecord = [[Record alloc] init];
    _hashTable[slot] = newRecord;
    [newRecord setKey:key];
    [newRecord setValue:obj];
    return YES;
  }
}

//Return the searched object or nil
//and delete the object from the table if not nil
-(RObject *)removeObjectWithKey:(RObject *)key;
{
  long hash = [key hash];
  int probe = 0;
  long slot = [self probeWithHash:hash atDepth:0];
  while (_hashTable[slot] && ![key isEqual:[_hashTable[slot] key]])
  {
    slot = [self probeWithHash:hash atDepth:++probe];
  }
  if (_hashTable[slot])
  {
    RObject * obj = [_hashTable[slot] value];
    [obj retain];
    [_hashTable[slot] release];
    _hashTable[slot] = _nil_slot;
    return obj;
  }
  else
  {
    return nil;
  }
}

//return the object if it can be found...
-(RObject *)objectWithKey:(RObject *)key
{
  long hash = [key hash];
  int probe = 0;
  long slot = [self probeWithHash:hash atDepth:0];
  while (_hashTable[slot] && ![key isEqual:[_hashTable[slot] key]])
  {
    slot = [self probeWithHash:hash atDepth:++probe];
  }
  if (_hashTable[slot])
  {
    return [_hashTable[slot] value];
  }
  else
  {
    return nil;
  }
}

-(int) numberOfCollisions
{
  return _collisions;
}

@end
