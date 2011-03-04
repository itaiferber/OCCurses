//
//  OCColor.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

/**
 Copyright (c) 2011 Itai Ferber
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
