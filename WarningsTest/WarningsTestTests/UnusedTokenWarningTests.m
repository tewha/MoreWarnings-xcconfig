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

//This *shouldn't* warn (since parameters often do go legitimately unused, especially in delegate methods). It is enabled by -Wextra and disabled explicitly immediately afterward.
- (bool) thing:(NSString *)str totallyIrrelevantParameter:(double)d {
	return (str != nil);
}
- (void) testUnusedParameter {
	STAssertTrue([self thing:@"foo" totallyIrrelevantParameter:42.0], @"thing:totallyIrrelevantParameter: returned false for a non-nil string!");
	STAssertFalse([self thing:nil totallyIrrelevantParameter:42.0], @"thing:totallyIrrelevantParameter: returned true for a nil string!");
}

@end
