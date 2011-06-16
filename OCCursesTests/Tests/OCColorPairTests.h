//
//  OCColorPairTests.h
//  OCCurses
//
//  Created by Itai Ferber on 3/18/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCColorPair.h"

/*!
 @class OCColorPairTests
 @discussion A unit test class for OCColorPair.
 */
@interface OCColorPairTests : SenTestCase {}

/*!
 @test Test Creation With Nil Colors
 @discussion Tests the creation of a new color pair object with nil foreground and background
 colors and verifies it to throw an exception.
 */
- (void)testCreationWithNilColors;

/*!
 @test Test Creation With Valid Colors
 @discussion Tests the creation of a new color pair object with valid foreground and background
 colors and verifies it to contain the correct colors.
 */
- (void)testCreationWithValidColors;

@end