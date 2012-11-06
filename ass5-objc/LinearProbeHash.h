#import "Hash.h"

@interface LinearProbeHash : Hash
{
  int _collisions;
}

-(int) numberOfCollisions;

@end
