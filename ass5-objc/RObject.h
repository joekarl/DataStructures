#import <objc/Object.h>

//Reference counted object

@interface Object (dealloc)
-(void)dealloc;
@end

@interface RObject : Object
{
  @private
  int _retainCount;
}

-(long)hash;

-(BOOL)isEqual:(id)other;

-(void)retain;
-(void)release;
-(int)retainCount;
-(void)dealloc;

@end

