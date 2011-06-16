//
//  OCBorderTests.m
//  OCCurses
//
//  Created by Itai Ferber on 3/8/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCBorderTests.h"
#include <curses.h>
#import "OCCharacter.h"


@implementation OCBorderTests

#pragma mark - Setup
static NSAutoreleasePool *pool = nil;
- (void)setUp {
	[super setUp];
	pool = [[NSAutoreleasePool alloc] init];
}

#pragma mark - Tests
- (void)testCreationWithNilString {
	OCBorder *border;
	STAssertThrows((border = [OCBorder borderWithComponentString:nil]), @"FAILURE: Expected border initialization to throw exception (instead: %@).", border);
}

- (void)testCreationWithEmptyString {
	OCBorder *border;
	STAssertThrows((border = [OCBorder borderWithComponentString:@""]), @"FAILURE: Expected border initialization to throw exception (instead: %@).", border);
}

- (void)testCreationWithInvalidString {
	OCBorder *border;
	STAssertThrows((border = [OCBorder borderWithComponentString:@"123456789"]), @"FAILURE: Expected border initialization to throw exception (instead: %@).", border);
}

- (void)testCreationWithValidString {
	OCBorder *border;
	STAssertNoThrow((border = [OCBorder borderWithComponentString:@"12345678"]), @"FAILURE: Expected border initialization to complete correctly (instead: %@).", border);
	STAssertTrue(border.topLeftCorner == '1', @"border.topLeftCorner == %u", border.topLeftCorner);
	STAssertTrue(border.topFill == '2', @"border.topFill == %u", border.topFill);
	STAssertTrue(border.topRightCorner == '3', @"border.topRightCorner === 3");
	STAssertTrue(border.leftFill == '4', @"border.leftFill === 4");
	STAssertTrue(border.rightFill == '5', @"border.rightFill === 5");
	STAssertTrue(border.bottomLeftCorner == '6', @"border.bottomLeftCorner === 6");
	STAssertTrue(border.bottomFill == '7', @"border.bottomFill === 7");
	STAssertTrue(border.bottomRightCorner == '8', @"border.bottomRightCorner === 8");
}

- (void)testCreationWithBorderComponents {
	unsigned int array[8] = {OCCharacterUpperLeftCorner, OCCharacterHorizontalLine, OCCharacterUpperRightCorner, OCCharacterVerticalLine, OCCharacterVerticalLine, OCCharacterLowerLeftCorner, OCCharacterHorizontalLine, OCCharacterLowerRightCorner};
	OCBorder *border = [OCBorder borderWithComponents:OCBorderComponentsFromArray(array)];
	STAssertTrue(border.topLeftCorner == OCCharacterUpperLeftCorner, @"border.topLeftCorner === OCCharacterUpperLeftCorner");
	STAssertTrue(border.topFill == OCCharacterHorizontalLine, @"border.topFill === OCCharacterHorizontalLine");
	STAssertTrue(border.topRightCorner == OCCharacterUpperRightCorner, @"border.topRightCorner === OCCharacterUpperRightCorner");
	STAssertTrue(border.leftFill == OCCharacterVerticalLine, @"border.leftFill === OCCharacterVerticalLine");
	STAssertTrue(border.rightFill == OCCharacterVerticalLine, @"border.rightFill === OCCharacterVerticalLine");
	STAssertTrue(border.bottomLeftCorner == OCCharacterLowerLeftCorner, @"border.bottomLeftCorner === OCCharacterLowerLeftCorner");
	STAssertTrue(border.bottomFill == OCCharacterHorizontalLine, @"border.bottomFill === OCCharacterHorizontalLine");
	STAssertTrue(border.bottomRightCorner == OCCharacterLowerRightCorner, @"border.bottomRightCorner === OCCharacterLowerRightCorner");
}

#pragma mark - Teardown
- (void)tearDown {
	[pool drain];
	[super tearDown];
}

@end