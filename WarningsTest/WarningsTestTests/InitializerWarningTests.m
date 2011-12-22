//
//  InitializerWarningTests.m
//  WarningsTest
//
//  Created by Peter Hosey on 2011-12-21.
//

#import "InitializerWarningTests.h"

@implementation InitializerWarningTests

- (void) testInitializerNotFullyBracketed {
	NSRect rect = { 0, 0, 640, 480 };
	STAssertEquals(rect.size.width, (CGFloat)640.0, @"Width not equal to 640!");
	STAssertEquals(rect.size.height, (CGFloat)480.0, @"Width not equal to 480!");
}

- (void) testMissingFieldInitializers {
	NSRect bounds = { { 640, 480 } }; //Note: Missing origin
	STAssertEquals(bounds.size.width, (CGFloat)640.0, @"Width not equal to 640!");
	STAssertEquals(bounds.size.height, (CGFloat)480.0, @"Width not equal to 480!");
}

@end
