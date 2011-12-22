//
//  AssortedWarningTests.m
//  WarningsTestTests
//
//  Created by Peter Hosey on 2011-12-21.
//

#import "AssortedWarningTests.h"

#include <mach/mach_time.h>

@implementation WarningsTestTests

- (void) setUp {
	srandom((unsigned)time(NULL));
}

- (void) testCheckSwitchStatements {
	enum {
		kFoo,
		kBar,
		kBaz,
		kQux,
	} value = ((int)random()) % 4;

	switch (value) {
		case kFoo:
			NSLog(@"Foo");
			break;
		case kBar:
			NSLog(@"Bar");
			break;
		case kBaz:
			NSLog(@"Baz");
			break;
		//kQux intentionally omitted (to trigger the warning)
	}
}

- (void) test64To32 {
	uint64_t absoluteTime = mach_absolute_time();
	uint64_t nanoseconds = UnsignedWideToUInt64(AbsoluteToNanoseconds(UInt64ToUnsignedWide(absoluteTime)));
	uint32_t fractionOfASecond = (nanoseconds % 1000000000ULL);
	STAssertTrue(fractionOfASecond >= 0, @"Strange number of nanoseconds after the whole second in %llu", nanoseconds);
}

- (void) testMissingParentheses {
	if (true)
		if (true)
			STAssertTrue(true, @"True!", true);
		if (false)
			STAssertFalse(false, @"False is true!", true);
}

- (void) testSignComparison {
	signed int temperature = -32;
	unsigned int freezingPoint = 0U;
	STAssertTrue(temperature > freezingPoint, @"Temperature is below freezing!");
}

- (void) testUndeclaredSelector {
	STAssertFalse([self respondsToSelector:@selector(onMyMark:getSet:go:)], @"Test case object responds to a made-up message!");
}

- (void) testFormat {
	NSUInteger answer = 42;
	//Don't actually run these at test time; just make sure they get compiled.
	if (time(NULL) == 0) {
		NSLog(@"Signed where we mean unsigned: %ld", answer);
		NSLog(@"Int where we mean long: %u", answer);
		NSLog(@"C string where we mean NSString: %s", self->fred);
		NSLog(@"NSObject where we mean C string: %@", __func__);
		NSLog(@"NSObject where we mean int: %@", answer);
	}
}

- (void) testDeprecatedFunctions {
	NSMutableArray *arrayOfOneThing = [NSMutableArray arrayWithObject:@"Frank"];
	enum { numIndices = 1U };
	NSUInteger indices[numIndices] = { 0UL };
	STAssertNoThrow([arrayOfOneThing removeObjectsFromIndices:indices numIndices:numIndices], @"Removing an object threw an exception!");

	NSWindow *window = nil;
	if (window || (time(NULL) == 0)) {
		NSRunAlertPanelRelativeToWindow(NSLocalizedString(@"OH NO!", /*comment*/ NULL), NSLocalizedString(@"The sky is falling!", /*comment*/ NULL), /*defaultButton*/ NSLocalizedString(@"Run!", /*comment*/ NULL), /*alternateButton*/ nil, /*otherButton*/ nil, window);
	}
}

- (void) testOverloadedVirtualFunctions {
	//We can't actually test this in pure Objective-C code. Someone will need to write an Objective-C++ test case class to do it.
}

- (void) testUndefinedUseOfOffsetof {
	//We can't actually test this in pure Objective-C code. Someone will need to write an Objective-C++ test case class to do it.
}

- (void) testNonVirtualDestructor {
	//We can't actually test this in pure Objective-C code. Someone will need to write an Objective-C++ test case class to do it.
}

@end