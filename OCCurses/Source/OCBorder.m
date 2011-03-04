//
//  OCBorder.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCBorder.h"


@implementation OCBorder

#pragma mark Synthesis
@synthesize borderComponents;

#pragma mark -
#pragma mark Initialization
+ (id)borderWithComponentString:(NSString *)aString {
	return [[[self alloc] initWithComponentString:aString] autorelease];
}

- (id)initWithComponentString:(NSString *)aString {
	if ((self = [super init])) {
		if (aString && [aString length] == 8) {
			borderComponents = [aString copy];
		} else {
			[self release], self = nil;
		}
	}
	
	return self;
}


#pragma mark -
#pragma mark Deallocation
- (void)dealloc {
	[borderComponents release], borderComponents = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Border Point Accessors
- (unichar)leftFill {
	return [borderComponents characterAtIndex:0];
}

- (unichar)rightFill {
	return [borderComponents characterAtIndex:1];
}

- (unichar)topFill {
	return [borderComponents characterAtIndex:2];
}

- (unichar)bottomFill {
	return [borderComponents characterAtIndex:3];
}

- (unichar)topLeftCorner {
	return [borderComponents characterAtIndex:4];
}

- (unichar)topRightCorner {
	return [borderComponents characterAtIndex:5];
}

- (unichar)bottomLeftCorner {
	return [borderComponents characterAtIndex:6];
}

- (unichar)bottomRightCorner {
	return [borderComponents characterAtIndex:7];
}

@end
