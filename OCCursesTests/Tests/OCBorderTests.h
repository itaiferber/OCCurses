//
//  OCBorderTests.h
//  OCCurses
//
//  Created by Itai Ferber on 3/8/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCBorder.h"

/*!
 @class OCBorderTests
 @discussion A unit test class for OCBorder.
 */
@interface OCBorderTests : SenTestCase {}

/*!
 @test Test Creation with Nil String
 @discussion Tests the creation of a border using a nil string and verifies it to return nil.
 */
- (void)testCreationWithNilString;

/*!
 @test Test Creation with Empty String
 @discussion Tests the creation of a border using an empty string and verifies it to return nil.
 */
- (void)testCreationWithEmptyString;

/*!
 @test Test Creation with Invalid String
 @discussion Tests the creation of a border with an invalid string (of length 9) and verifies it to
 return nil.
 */
- (void)testCreationWithInvalidString;

/*!
 @test Test Creation with Valid String
 @discussion Tests the creation of a border with a valid string (of length 8) 
 */
- (void)testCreationWithValidString;

/*@
 @test Test Border Contents
 @discussion Tests the creation of a border with a valid string and verifies its contents to be in
 order.
 */
- (void)testBorderContents;

@end