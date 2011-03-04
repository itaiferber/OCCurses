//
//  OCAttribute.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCAttribute.h"


@implementation OCAttribute

#pragma mark Synthesis
@synthesize attributeIdentifier;

#pragma mark -
#pragma mark Initialization
+ (id)attributeWithAttributeIdentifier:(OCAttributeIdentifier)anIdentifier {
	return [[[self alloc] initWithAttributeIdentifier:anIdentifier] autorelease];
}

- (id)initWithAttributeIdentifier:(OCAttributeIdentifier)anIdentifier {
	if ((self = [super init])) {
		attributeIdentifier = anIdentifier;
	}
	
	return self;
}

@end
