//
//  OCColorPairTests.m
//  OCCurses
//
//  Created by Itai Ferber on 3/18/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCColorPairTests.h"


@implementation OCColorPairTests

#pragma mark - Setup
static NSAutoreleasePool *pool = nil;
- (void)setUp {
	[super setUp];
	pool = [[NSAutoreleasePool alloc] init];
}

#pragma mark - Tests
- (void)testCreationWithNilColors {
	STAssertNil([OCColorPair colorPairWithForegroundColor:nil backgroundColor:nil], @"FAILURE: Expected color pair to be nil with nil foreground and background colors!");
}

- (void)testCreationWithValidColors {
	OCColorPair *pair = [OCColorPair colorPairWithForegroundColor:[OCColor blackColor] backgroundColor:[OCColor blackColor]];
	STAssertNotNil(pair, @"FAILURE: Expected color pair to be initialized correctly (%@ instead)!", pair);
	STAssertEqualObjects([pair foregroundColor], [OCColor blackColor], @"FAILURE: Expected foreground color of pair to be black (%@ instead)!", [pair foregroundColor]);
	STAssertEqualObjects([pair backgroundColor], [OCColor blackColor], @"FAILURE: Expected background color of pair to be black (%@ instead)!", [pair backgroundColor]);
}

#pragma mark - Teardown
- (void)tearDown {
	[pool drain];
	[super tearDown];
}

@end