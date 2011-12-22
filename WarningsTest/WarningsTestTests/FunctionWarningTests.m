//
//  FunctionWarningTests.m
//  WarningsTest
//
//  Created by Peter Hosey on 2011-12-21.
//

#import "FunctionWarningTests.h"

static functionWithoutReturnType(void);
static int functionWithReturnType(void);

static void unusedFunction(void);

@implementation FunctionWarningTests

- (void) testMismatchedReturnType {
	STAssertNoThrow(functionWithoutReturnType(), @"functionWithoutReturnType threw an exception!");
	STAssertEquals(functionWithReturnType(), 42, @"functionWithReturnType returned something other than 42!");
}

- (void) testMissingPrototypes {
	STAssertEquals(functionWithNoPrototype(), M_PI, @"functionWithNoPrototype returned something not equal to pi!");
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
