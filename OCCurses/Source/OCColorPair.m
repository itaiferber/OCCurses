//
//  OCColorPair.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCColorPair.h"


@implementation OCColorPair

#pragma mark Synthesis
@synthesize foregroundColor;
@synthesize backgroundColor;

#pragma mark -
#pragma mark Initialization
+ (id)colorPairWithForegroundColor:(OCColor *)aForeground background:(OCColor *)aBackground {
	return [[[self alloc] initWithForegroundColor:aForeground background:aBackground] autorelease];
}

static OCAttributeIdentifier currentPairIdentifier = 1;
- (id)initWithForegroundColor:(OCColor *)aForeground background:(OCColor *)aBackground {
	if ((self = [super initWithAttributeIdentifier:currentPairIdentifier])) {
		if (aForeground && aBackground) {
			foregroundColor = [aForeground retain];
			backgroundColor = [aBackground retain];
			init_pair(currentPairIdentifier++, foregroundColor.colorIdentifier, backgroundColor.colorIdentifier);
		} else {
			[self release], self = nil;
		}
	}
	
	return self;
}

@end
