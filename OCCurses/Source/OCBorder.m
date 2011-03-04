//
//  OCBorder.m
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
