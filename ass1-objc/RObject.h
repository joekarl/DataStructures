#import <objc/Object.h>

@interface Object (dealloc)
-(void)dealloc;
@end

@interface RObject : Object
{
  @private
  int _retainCount;
}

-(void)retain;
-(void)release;
-(int)retainCount;
-(void)dealloc;

@end

