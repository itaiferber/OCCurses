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
 @discussion Tests the creation of a border using a nil string and verifies it to throw an
 exception.
 */
- (void)testCreationWithNilString;

/*!
 @test Test Creation with Empty String
 @discussion Tests the creation of a border using an empty string and verifies it to throw an
 exception.
 */
- (void)testCreationWithEmptyString;

/*!
 @test Test Creation with Invalid String
 @discussion Tests the creation of a border with an invalid string (of length 9) and verifies it to
 throw an exception.
 */
- (void)testCreationWithInvalidString;

/*!
 @test Test Creation with Valid String
 @discussion Tests the creation of a border with a valid string (of length 8) and verifies it to
 contain the correct characters.
 */
- (void)testCreationWithValidString;

/*!
 @test Test Creation with Border Components
 @discussion Tests the creation of a border with a given border component structure and verifies it
 to contain the correct characters.
 */
- (void)testCreationWithBorderComponents;

@end