//
//  DeprecationWarningTests.m
//  WarningsTest
//
//  Created by Peter Hosey on 2011-12-22.
//

#import "DeprecationWarningTests.h"

@interface Foo : NSObject
- (void) doThing DEPRECATED_ATTRIBUTE;
@end

@interface Bar : Foo
@end

@implementation DeprecationWarningTests

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

@end

@implementation Foo

- (void) doThing {
	NSLog(@"%@", __func__);
}

@end

@implementation Bar : Foo

- (void) doThing {
	NSLog(@"This is the override of a deprecated method");
	[super doThing];
}

@end
