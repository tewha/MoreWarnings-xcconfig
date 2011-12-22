//
//  UnusedTokenWarningTests.m
//  WarningsTest
//
//  Created by Peter Hosey on 2011-12-21.
//

#import "UnusedTokenWarningTests.h"

@implementation UnusedTokenWarningTests

- (void) testUnusedLabel {
	STAssertTrue(true, @"True is not true!");
testFalse:
	STAssertFalse(false, @"False is not false!");
}

- (void) testUnusedValue {
	4 + 4;
	STAssertTrue(4 + 4, @"4 + 4 is false!");
}

- (void) testUnusedVariable {
	NSUInteger answer = 42;
	STAssertTrue(true, @"True is not true!");
}

@end
