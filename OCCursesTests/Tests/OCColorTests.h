//
//  OCColorTests.h
//  OCCurses
//
//  Created by Itai Ferber on 3/8/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCColor.h"

/*!
 @class OCColorTests
 @discussion A unit test class for OCColor.
 */
@interface OCColorTests : SenTestCase {}

/*!
 @test Test Black Color
 @discussion Tests the proper creation of the black color.
 */
- (void)testBlackColor;

/*!
 @test Test Red Color
 @discussion Tests the proper creation of the red color.
 */
- (void)testRedColor;

/*!
 @test Test Green Color
 @discussion Tests the proper creation of the green color.
 */
- (void)testGreenColor;

/*!
 @test Test Yellow Color
 @discussion Tests the proper creation of the yellow color.
 */
- (void)testYellowcolor;

/*!
 @test Test Blue Color
 @discussion Tests the proper creation of the blue color.
 */
- (void)testBlueColor;

/*!
 @test Test Magenta Color
 @discussion Tests the proper creation of the magenta color.
 */
- (void)testMagentaColor;

/*!
 @test Test Cyan Color
 @discussion Tests the proper creation of the cyan color.
 */
- (void)testCyanColor;

/*!
 @test Test White Color
 @discussion Tests the proper creation of the white color.
 */
- (void)testWhiteColor;

@end