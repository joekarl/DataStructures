
#import "LinearProbeHash.h"
#import "ModifiedLinearProbeHash.h"
#import "CollisionKey.h"
#import <stdio.h>
#import <assert.h>

int main()
{
 
  id obj1 = [[RObject alloc] init];
  id obj2 = [[RObject alloc] init];
  id obj3 = [[RObject alloc] init];
  id obj4 = [[RObject alloc] init];
  id obj5 = [[RObject alloc] init];
  
  id key1 = [[RObject alloc] init];
  id key2 = [[CollisionKey alloc] init];
  id key3 = [[CollisionKey alloc] init];
  id key4 = [[RObject alloc] init];
  id key5 = [[RObject alloc] init];

  id linearProbeHash = [[LinearProbeHash alloc] initWithCapacity:5];
  [linearProbeHash insert:obj1 withKey:key1];
  [linearProbeHash insert:obj2 withKey:key2];
  [linearProbeHash insert:obj3 withKey:key3];

  id hopefullyObj2 = [linearProbeHash objectWithKey:key2];
  assert([hopefullyObj2 isEqual:obj2]);
  [hopefullyObj2 release];

  [linearProbeHash insert:obj4 withKey:key4];
  [linearProbeHash insert:obj5 withKey:key5];
  
  id hopefullyObj3 = [linearProbeHash objectWithKey:key3];
  assert([hopefullyObj3 isEqual:obj3]);
  [hopefullyObj3 release];

  printf("Done with linear probe test\n");

  //*//
  id modifiedLinearProbeHash = [[ModifiedLinearProbeHash alloc] initWithCapacity:5];
  [modifiedLinearProbeHash insert:obj1 withKey:key1];
  [modifiedLinearProbeHash insert:obj2 withKey:key2];
  [modifiedLinearProbeHash insert:obj3 withKey:key3];
 
  hopefullyObj2 = [modifiedLinearProbeHash objectWithKey:key2];
  assert([hopefullyObj2 isEqual:obj2]);
  [hopefullyObj2 release];
  
  
  [modifiedLinearProbeHash insert:obj4 withKey:key4];
  [modifiedLinearProbeHash insert:obj5 withKey:key5];
  
  hopefullyObj3 = [modifiedLinearProbeHash objectWithKey:key3];
  assert([hopefullyObj3 isEqual:obj3]);
  [hopefullyObj3 release];
  
  hopefullyObj2 = [modifiedLinearProbeHash objectWithKey:key2];
  assert([hopefullyObj2 isEqual:obj2]);
  [hopefullyObj2 release];

  printf("Done with linear probe test\n");
  //*/ 
  return 0;
}

