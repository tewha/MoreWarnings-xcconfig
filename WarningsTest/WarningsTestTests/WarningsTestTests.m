//
//  WarningsTestTests.m
//  WarningsTestTests
//
//  Created by Peter Hosey on 2011-12-21.
//

#import "WarningsTestTests.h"

#include <mach/mach_time.h>

NSString *fred = @"Fred";

static functionWithoutReturnType(void);
static int functionWithReturnType(void);

static void unusedFunction(void);

@implementation WarningsTestTests
{
	NSString *fred, *wilma;
}

- (void) setUp {
	self->fred = @"Fred";
	self->wilma = @"Wilma";

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
- (void) testCheckLocalShadowsInstanceVariable {
	NSString *wilma = @"Wilma";
	STAssertEqualObjects(wilma, @"Wilma", @"Local variable wilma was not equal to @\"Wilma\"");
}
- (void) testCheckLocalShadowsGlobal {
	NSString *fred = @"Fred";
	STAssertEqualObjects(fred, @"Fred", @"Local variable wilma was not equal to @\"Fred\"");
}
- (void) testCheckInstanceVariableShadowsGlobal {
	STAssertEqualObjects(fred, @"Fred", @"Instance variable wilma was not equal to @\"Fred\"");
}

- (void) test64To32 {
	uint64_t absoluteTime = mach_absolute_time();
	uint64_t nanoseconds = UnsignedWideToUInt64(AbsoluteToNanoseconds(UInt64ToUnsignedWide(absoluteTime)));
	uint32_t fractionOfASecond = (nanoseconds % 1000000000ULL);
	STAssertTrue(fractionOfASecond >= 0, @"Strange number of nanoseconds after the whole second in %llu", nanoseconds);
}

- (void) testInitializerNotFullyBracketed {
	NSRect rect = { 0, 0, 640, 480 };
	STAssertEquals(rect.size.width, (CGFloat)640.0, @"Width not equal to 640!");
	STAssertEquals(rect.size.height, (CGFloat)480.0, @"Width not equal to 480!");
}

- (void) testMismatchedReturnType {
	STAssertNoThrow(functionWithoutReturnType(), @"functionWithoutReturnType threw an exception!");
	STAssertEquals(functionWithReturnType(), 42, @"functionWithReturnType returned something other than 42!");
}

- (void) testMissingParentheses {
	if (true)
		if (true)
			STAssertTrue(true, @"True!", true);
		if (false)
			STAssertFalse(false, @"False is true!", true);
}

- (void) testMissingFieldInitializers {
	NSRect bounds = { { 640, 480 } }; //Note: Missing origin
	STAssertEquals(bounds.size.width, (CGFloat)640.0, @"Width not equal to 640!");
	STAssertEquals(bounds.size.height, (CGFloat)480.0, @"Width not equal to 480!");
}

- (void) testSignComparison {
	signed int temperature = -32;
	unsigned int freezingPoint = 0U;
	STAssertTrue(temperature > freezingPoint, @"Temperature is below freezing!");
}

- (void) testUndeclaredSelector {
	STAssertFalse([self respondsToSelector:@selector(onMyMark:getSet:go:)], @"Test case object responds to a made-up message!");
}

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

- (void) testMissingPrototypes {
	STAssertEquals(functionWithNoPrototype(), M_PI, @"functionWithNoPrototype returned something not equal to pi!");
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

static functionWithoutReturnType(void) {
	return 42;
}
static int functionWithReturnType(void) {
	return;
}

static void unusedFunction(void) {
	enum { HORIZONTAL_ELLIPSIS = 0x2026 };
	NSLog(@"I'm so lonely%C", HORIZONTAL_ELLIPSIS);
}

static double functionWithNoPrototype(void) {
	return M_PI;
}