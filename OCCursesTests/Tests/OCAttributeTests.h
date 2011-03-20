//
//  OCAttributeTests.h
//  OCCurses
//
//  Created by Itai Ferber on 3/18/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCAttribute.h"


/*!
 @class OCAttributeTests
 @discussion A unit test class for OCAttribute.
 */
@interface OCAttributeTests : SenTestCase {}

/*!
 @test Test Creation With Valid Attribute Identifier
 @discussion Tests the creation of an OCAttribute with a valid identifier and verifies it to not be
 nil.
 */
- (void)testCreationWithValidAttributeIdentifier;

@end