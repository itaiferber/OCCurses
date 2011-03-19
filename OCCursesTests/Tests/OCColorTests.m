//
//  OCColorTests.m
//  OCCurses
//
//  Created by Itai Ferber on 3/8/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCColorTests.h"


@implementation OCColorTests

#pragma mark - Setup
static NSAutoreleasePool *pool = nil;
- (void)setUp {
	[super setUp];
	pool = [[NSAutoreleasePool alloc] init];
}

#pragma mark - Tests
- (void)testBlackColor {
	STAssertTrue([[OCColor blackColor] colorIdentifier] == OCColorBlack, @"[OCColor blackColor].colorIdentifier === OCColorBlack");
}

- (void)testRedColor {
	STAssertTrue([[OCColor redColor] colorIdentifier] == OCColorRed, @"[OCColor redColor].colorIdentifier === OCColorRed");
}

- (void)testGreenColor {
	STAssertTrue([[OCColor greenColor] colorIdentifier] == OCColorGreen, @"[OCColor greenColor].colorIdentifier === OCColorGreen");
}

- (void)testYellowcolor {
	STAssertTrue([[OCColor yellowColor] colorIdentifier] == OCColorYellow, @"[OCColor yellowColor].colorIdentifier === OCColorYellow");
}

- (void)testBlueColor {
	STAssertTrue([[OCColor blueColor] colorIdentifier] == OCColorBlue, @"[OCColor blueColor].colorIdentifier === OCColorBlue");
}

- (void)testMagentaColor {
	STAssertTrue([[OCColor magentaColor] colorIdentifier] == OCColorMagenta, @"[OCColor magentaColor].colorIdentifier === OCColorMagenta");
}

- (void)testCyanColor {
	STAssertTrue([[OCColor cyanColor] colorIdentifier] == OCColorCyan, @"[OCColor cyanColor].colorIdentifier === OCCyanColor");
}

- (void)testWhiteColor {
	STAssertTrue([[OCColor whiteColor] colorIdentifier] == OCColorWhite, @"[OCColor whiteColor].colorIdentifier == OCColorWhite");
}

#pragma mark - Teardown
- (void)tearDown {
	[pool drain];
	[super tearDown];
}

@end