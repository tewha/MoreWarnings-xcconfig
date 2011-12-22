//
//  ShadowingWarningTests.m
//  WarningsTest
//
//  Created by Peter Hosey on 2011-12-21.
//  Copyright (c) 2011 Captured Magic, LLC. All rights reserved.
//

#import "ShadowingWarningTests.h"

NSString *fred = @"Fred";

@implementation ShadowingWarningTests
{
	NSString *fred, *wilma;
}

- (void) setUp {
	self->fred = @"Fred";
	self->wilma = @"Wilma";
}

- (void) testLocalShadowsInstanceVariable {
	NSString *wilma = @"Wilma";
	STAssertEqualObjects(wilma, @"Wilma", @"Local variable wilma was not equal to @\"Wilma\"");
}
- (void) testLocalShadowsGlobal {
	NSString *fred = @"Fred";
	STAssertEqualObjects(fred, @"Fred", @"Local variable wilma was not equal to @\"Fred\"");
}
- (void) testInstanceVariableShadowsGlobal {
	STAssertEqualObjects(fred, @"Fred", @"Instance variable wilma was not equal to @\"Fred\"");
}

@end
