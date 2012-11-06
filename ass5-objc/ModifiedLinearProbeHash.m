
#import "ModifiedLinearProbeHash.h"
#import <stdio.h>

@interface ModifiedLinearProbeHash(pvt)

-(long)probeWithHash:(long)hash atDepth:(int)depth;

@end

@implementation ModifiedLinearProbeHash(pvt)

-(long)probeWithHash:(long)hash atDepth:(int)depth
{
  return (hash + depth) % _capacity;
}

@end

@implementation ModifiedLinearProbeHash

//insert an item with a key
//will return YES for success or NO for failure
-(BOOL)insert:(RObject *)obj withKey:(RObject *)key;
{
  long hash = [key hash];
  long startingSlot = [self probeWithHash:hash atDepth:0];
  long slot = startingSlot;
  Record * temp = nil;
  if (!_hashTable[slot])
  {
    Record * newRecord = [[Record alloc] init];
    [newRecord setKey:key];
    [newRecord setValue:obj];
    _hashTable[slot] = newRecord;
    return YES;
  }
  while ((((slot + 1) % _capacity) != startingSlot) 
    && _hashTable[slot] && ![_hashTable[slot] isEqual:_nil_slot])
  {
    Record * newRecord = temp;
    if (!newRecord)
    {
      newRecord = [[Record alloc] init];
      [newRecord setKey:key];
      [newRecord setValue:obj];
    }
    temp = _hashTable[slot];
    _hashTable[slot] = newRecord;
    slot++;
    _collisions++;
  }
  if (temp && slot % _capacity != startingSlot) 
  {
    _hashTable[slot] = temp;
    return YES;
  }

  return NO;
}

//delete object from hash if found 
//will return the found object
//if not will return nil
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

//retrieve object based on key or return nil
-(RObject *)objectWithKey:(RObject *)key;
{
  long hash = [key hash];
  int probe = 0;
  long slot = [self probeWithHash:hash atDepth:probe];
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
