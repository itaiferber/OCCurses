//
//  OCAttributeTests.m
//  OCCurses
//
//  Created by Itai Ferber on 3/18/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCAttributeTests.h"


@implementation OCAttributeTests

#pragma mark - Setup
static NSAutoreleasePool *pool = nil;
- (void)setUp
{
    [super setUp];
    pool = [[NSAutoreleasePool alloc] init];
}

#pragma mark - Tests
- (void)testCreationWithValidAttributeIdentifier {
	OCAttribute *attribute = [OCAttribute attributeWithAttributeIdentifier:OCAttributeNormal];
	STAssertNotNil(attribute, @"FAILURE: Expected attribute to be initialized correctly (instead %@)!", attribute);
	STAssertEquals(attribute.attributeIdentifier, OCAttributeNormal, @"FAILURE: Expected attribute identifier to be normal (instead %d)!", attribute.attributeIdentifier);
}

#pragma mark - Teardown
- (void)tearDown
{
    [pool drain];
    [super tearDown];
}

@end