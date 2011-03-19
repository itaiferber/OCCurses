//
//  OCColorPair.m
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

#import "OCColorPair.h"


@implementation OCColorPair

#pragma mark - Synthesis
@synthesize foregroundColor = _foregroundColor;
@synthesize backgroundColor = _backgroundColor;

#pragma mark - Initialization
+ (id)colorPairWithForegroundColor:(OCColor *)aForeground backgroundColor:(OCColor *)aBackground {
	return [[[self alloc] initWithForegroundColor:aForeground backgroundColor:aBackground] autorelease];
}

static OCAttributeIdentifier currentPairIdentifier = 1;
- (id)initWithForegroundColor:(OCColor *)aForeground backgroundColor:(OCColor *)aBackground {
	if ((self = [super initWithAttributeIdentifier:currentPairIdentifier])) {
		if (aForeground && aBackground) {
			_foregroundColor = [aForeground retain];
			_backgroundColor = [aBackground retain];
			init_pair(currentPairIdentifier++, _foregroundColor.colorIdentifier, _backgroundColor.colorIdentifier);
		} else {
			[self release], self = nil;
		}
	}
	
	return self;
}

#pragma mark - Is Equal
- (BOOL)isEqual:(id)object {
	if ([object isKindOfClass:[OCColorPair class]]) {
		return [((OCColorPair *)object).foregroundColor isEqual:_foregroundColor] && [((OCColorPair *)object).backgroundColor isEqual:_backgroundColor];
	} else {
		return NO;
	}
}

#pragma mark - Description
- (NSString *)description {
	return [NSString stringWithFormat:@"<OCColorPair: %@, %@>", _foregroundColor, _backgroundColor];
}

@end