//
//  KKQuantifiersTests.m
//  KKQuantifiersTests
//
//  Created by Karol Kozub on 2015-04-07.
//
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "KKQuantifiers.h"


@interface KKQuantifiersTests : XCTestCase
@end


@implementation KKQuantifiersTests

- (void)testAnyOfUniformCollection
{
  NSArray *objects = @[@"This", @"is", @"a", @"test", @"!"];

  XCTAssert([AnyOf(objects) containsString:@"This"]);
  XCTAssert([AnyOf(objects) containsString:@"is"]);
  XCTAssert([AnyOf(objects) containsString:@"a"]);
  XCTAssert([AnyOf(objects) containsString:@"test"]);

  XCTAssertFalse([AnyOf(objects) containsString:@"These"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"words"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"are"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"different"]);
}

- (void)testAnyOfEmptyCollection
{
  NSArray *objects = @[];

  XCTAssertFalse([AnyOf(objects) containsString:@"These"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"words"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"are"]);
  XCTAssertFalse([AnyOf(objects) containsString:@"different"]);
}

- (void)testAnyOfDifferentObjects
{
  NSArray *objects = @[@1.1, @"test", @123];

  XCTAssert([AnyOf(objects) isEqualToNumber:@1.1]);
  XCTAssert([AnyOf(objects) containsString:@"test"]);
  XCTAssert([AnyOf(objects) isEqualToNumber:@123]);

  XCTAssertFalse([AnyOf(objects) isEqualToNumber:@123.123]);
  XCTAssertFalse([AnyOf(objects) containsString:@"words"]);
  XCTAssertFalse([AnyOf(objects) isEqualToNumber:@123123]);
}

- (void)testAnyOfObjectsRespondingToSelector
{
  NSArray *objects = @[@1.1, @"test", @123];

  XCTAssert([AnyOf(objects) respondsToSelector:@selector(containsString:)]);
  XCTAssert([AnyOf(objects) respondsToSelector:@selector(isEqualToNumber:)]);

  XCTAssertFalse([AnyOf(objects) respondsToSelector:@selector(addObject:)]);
  XCTAssertFalse([AnyOf(objects) respondsToSelector:@selector(array)]);
}

- (void)testEachOfUniformCollection
{
  NSArray *objects = @[@"This is a test", @"That was a test", @"And another test"];

  XCTAssert([EachOf(objects) containsString:@"test"]);
  XCTAssert([EachOf(objects) containsString:@"a"]);

  XCTAssertFalse([EachOf(objects) containsString:@"This"]);
  XCTAssertFalse([EachOf(objects) containsString:@"is"]);
  XCTAssertFalse([EachOf(objects) containsString:@"something"]);
}

- (void)testEachOfEmptyCollection
{
  NSArray *objects = @[];

  XCTAssert([EachOf(objects) containsString:@"This"]);
  XCTAssert([EachOf(objects) containsString:@"is"]);
  XCTAssert([EachOf(objects) containsString:@"a"]);
  XCTAssert([EachOf(objects) containsString:@"test"]);
}

- (void)testEachOfDifferentObjects
{
  NSArray *objects = @[@1.1, @"test", @123];

  XCTAssertFalse([EachOf(objects) isEqualToNumber:@1.1]);
  XCTAssertFalse([EachOf(objects) containsString:@"test"]);
  XCTAssertFalse([EachOf(objects) isEqualToNumber:@123]);
  XCTAssertFalse([AnyOf(objects) isEqualToNumber:@123.123]);
  XCTAssertFalse([AnyOf(objects) containsString:@"words"]);
  XCTAssertFalse([AnyOf(objects) isEqualToNumber:@123123]);
}

- (void)testEachOfObjectsRespondingToSelector
{
  NSArray *objects = @[@1.1, @"test", @123];

  XCTAssert([EachOf(objects) respondsToSelector:@selector(hash)]);
  XCTAssert([EachOf(objects) respondsToSelector:@selector(isEqual:)]);

  XCTAssertFalse([EachOf(objects) respondsToSelector:@selector(containsString:)]);
  XCTAssertFalse([EachOf(objects) respondsToSelector:@selector(addObject:)]);
}

@end
