//
//  OCBorderTests.m
//  OCCurses
//
//  Created by Itai Ferber on 3/8/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCBorderTests.h"


@implementation OCBorderTests

#pragma mark - Setup
static NSAutoreleasePool *pool = nil;
- (void)setUp {
	[super setUp];
	pool = [[NSAutoreleasePool alloc] init];
}

#pragma mark - Tests
- (void)testCreationWithNilString {
	OCBorder *border = [OCBorder borderWithComponentString:nil];
	STAssertNil(border, @"FAILURE: Expected border to be set to nil (instead %@)!", border);
}

- (void)testCreationWithEmptyString {
	OCBorder *border = [OCBorder borderWithComponentString:@""];
	STAssertNil(border, @"FAILURE: Expected border to be set to nil (instead %@)!", border);
}

- (void)testCreationWithInvalidString {
	OCBorder *border = [OCBorder borderWithComponentString:@"123456789"];
	STAssertNil(border, @"FAILURE: Expected border to be set to nil (instead %@)!", border);
}

- (void)testCreationWithValidString {
	OCBorder *border = [OCBorder borderWithComponentString:@"12345678"];
	STAssertNotNil(border, @"FAILURE: Expected border to be initialized successfully (instead %@)!", border);
}

- (void)testBorderContents {
	OCBorder *border = [OCBorder borderWithComponentString:@"45271368"];
	STAssertTrue(border.topLeftCorner == '1', @"border.topLeftCorner === 1");
	STAssertTrue(border.topFill == '2', @"border.topFill === 2");
	STAssertTrue(border.topRightCorner == '3', @"border.topRightCorner === 3");
	STAssertTrue(border.leftFill == '4', @"border.leftFill === 4");
	STAssertTrue(border.rightFill == '5', @"border.rightFill === 5");
	STAssertTrue(border.bottomLeftCorner == '6', @"border.bottomLeftCorner === 6");
	STAssertTrue(border.bottomFill == '7', @"border.bottomFill === 7");
	STAssertTrue(border.bottomRightCorner == '8', @"border.bottomRightCorner === 8");
}

#pragma mark - Teardown
- (void)tearDown {
	[pool drain];
	[super tearDown];
}

@end