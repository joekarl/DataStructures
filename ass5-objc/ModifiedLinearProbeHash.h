#import "Hash.h"

@interface ModifiedLinearProbeHash : Hash
{
  int _collisions;
}

-(int) numberOfCollisions;


@end
