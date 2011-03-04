//
//  OCColor.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCColor.h"

@interface OCColor ()
#pragma mark Private Methods
+ (id)colorWithColorIdentifier:(OCColorIdentifier)anIdentifier;
- (id)initWithColorIdentifier:(OCColorIdentifier)anIdentifier;
@end

#pragma mark -
@implementation OCColor

#pragma mark Synthesis
@synthesize colorIdentifier;

#pragma mark -
#pragma mark Initialization
+ (id)colorWithColorIdentifier:(OCColorIdentifier)anIdentifier {
	return [[[self alloc] initWithColorIdentifier:anIdentifier] autorelease];
}

- (id)initWithColorIdentifier:(OCColorIdentifier)anIdentifier {
	if ((self = [super init])) {
		colorIdentifier = anIdentifier;
	}
	
	return self;
}

#pragma mark -
#pragma mark Color-Specific Methods
+ (id)blackColor {
	return [self colorWithColorIdentifier:OCColorBlack];
}

+ (id)redColor {
	return [self colorWithColorIdentifier:OCColorRed];
}

+ (id)greenColor {
	return [self colorWithColorIdentifier:OCColorGreen];
}

+ (id)yellowColor {
	return [self colorWithColorIdentifier:OCColorYellow];
}

+ (id)blueColor {
	return [self colorWithColorIdentifier:OCColorBlue];
}

+ (id)magentaColor {
	return [self colorWithColorIdentifier:OCColorMagenta];
}

+ (id)cyanColor {
	return [self colorWithColorIdentifier:OCColorCyan];
}

+ (id)whiteColor {
	return [self colorWithColorIdentifier:OCColorWhite];
}

@end
