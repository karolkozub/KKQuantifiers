//
//  KKQuantifiers.m
//  KKQuantifiers
//
//  Created by Karol Kozub on 2015-04-07.
//
//

#import "KKQuantifiers.h"


@interface KKQuantifier : NSObject

@property (nonatomic, strong, readonly) id<NSFastEnumeration> collection;

@end


@interface KKAnyOfQuantifier : KKQuantifier
@end


@interface KKEachOfQuantifier : KKQuantifier
@end


@implementation KKQuantifier

- (instancetype)initWithCollection:(id<NSFastEnumeration>)collection
{
  self = [super init];

  if (self) {
    _collection = collection;
  }

  return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
  for (id object in self.collection) {
    NSMethodSignature *methodSignature = [object methodSignatureForSelector:aSelector];

    if (methodSignature) {
      NSAssert([@(methodSignature.methodReturnType) isEqual:@(@encode(BOOL))], @"Only methods returning BOOL are supported");

      return methodSignature;
    }
  }

  return [NSMethodSignature signatureWithObjCTypes:@encode(BOOL)];
}

@end


@implementation KKAnyOfQuantifier

- (BOOL)respondsToSelector:(SEL)aSelector
{
  for (id object in self.collection) {
    if ([object respondsToSelector:aSelector]) {
      return YES;
    }
  }

  return NO;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
  BOOL returnValue = NO;
  [anInvocation setReturnValue:&returnValue];

  for (id object in self.collection) {
    if ([object respondsToSelector:anInvocation.selector]) {
      [anInvocation invokeWithTarget:object];
      [anInvocation getReturnValue:&returnValue];

      if (returnValue) {
        return;
      }
    }
  }
}

@end


@implementation KKEachOfQuantifier

- (BOOL)respondsToSelector:(SEL)aSelector
{
  for (id object in self.collection) {
    if (![object respondsToSelector:aSelector]) {
      return NO;
    }
  }

  return YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
  BOOL returnValue = YES;
  [anInvocation setReturnValue:&returnValue];

  for (id object in self.collection) {
    if ([object respondsToSelector:anInvocation.selector]) {
      [anInvocation invokeWithTarget:object];
      [anInvocation getReturnValue:&returnValue];

      if (!returnValue) {
        return;
      }
    } else {
      returnValue = NO;
      [anInvocation setReturnValue:&returnValue];
      return;
    }
  }
}

@end


id AnyOf(id<NSFastEnumeration> collection)
{
  return [[KKAnyOfQuantifier alloc] initWithCollection:collection];
}

id EachOf(id<NSFastEnumeration> collection)
{
  return [[KKEachOfQuantifier alloc] initWithCollection:collection];
}
