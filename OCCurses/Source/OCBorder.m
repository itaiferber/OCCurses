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

OCBorderComponents OCBorderComponentsFromString (NSString *string) {
	if (!string || [string length] != 8) @throw NSInvalidArgumentException;
	const char *characters = [string UTF8String];
	unsigned int *array = alloca([string length] * sizeof(unsigned int));
	if (array == NULL) @throw NSMallocException;
	
	for (NSUInteger index = 0; index < [string length]; index++) {
		array[index] = characters[index];
	}
	
	return OCBorderComponentsFromArray(array);
}

OCBorderComponents OCBorderComponentsFromArray (const unsigned int *array) {
	if (array == NULL) @throw NSInvalidArgumentException;
	return (OCBorderComponents){array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]};
}

BOOL OCEqualBorderComponents (OCBorderComponents first, OCBorderComponents second) {
	return first.topLeftCorner == second.topLeftCorner && 
		   first.topFill == second.topFill &&
		   first.topRightCorner == second.topRightCorner &&
		   first.leftFill == second.leftFill &&
		   first.rightFill == second.rightFill &&
		   first.bottomLeftCorner == second.bottomLeftCorner &&
		   first.bottomFill == second.bottomFill &&
		   first.bottomRightCorner == second.bottomRightCorner;
}

@implementation OCBorder

#pragma mark - Initialization
+ (id)borderWithComponentString:(NSString *)theString {
	return [[self alloc] initWithComponentString:theString];
}

+ (id)borderWithComponents:(OCBorderComponents)theComponents {
	return [[self alloc] initWithComponents:theComponents];
}

- (id)initWithComponentString:(NSString *)theString {
	if (!(theString && [theString length] == 8)) @throw NSInvalidArgumentException;
	if ((self = [super init])) {
		_borderComponents = OCBorderComponentsFromString(theString);
	}
	
	return self;
}

- (id)initWithComponents:(OCBorderComponents)theComponents {
	if ((self = [super init])) {
		_borderComponents = theComponents;
	}
	
	return self;
}

#pragma mark - Border Components
- (unsigned int)topLeftCorner {
	return _borderComponents.topLeftCorner;
}

- (unsigned int)topFill {
	return _borderComponents.topFill;
}

- (unsigned int)topRightCorner {
	return _borderComponents.topRightCorner;
}

- (unsigned int)leftFill {
	return _borderComponents.leftFill;
}

- (unsigned int)rightFill {
	return _borderComponents.rightFill;
}

- (unsigned int)bottomLeftCorner {
	return _borderComponents.bottomLeftCorner;
}

- (unsigned int)bottomFill {
	return _borderComponents.bottomFill;
}

- (unsigned int)bottomRightCorner {
	return _borderComponents.bottomRightCorner;
}

#pragma mark - Equality Testing
- (BOOL)isEqual:(id)object {
	if (!([object isKindOfClass:[OCBorder class]] && [object hash] == [self hash])) return NO;
	return OCEqualBorderComponents(_borderComponents, ((OCBorder *)object)->_borderComponents);
}

- (NSUInteger)hash {
	// Produces a fairly distinctive hash. NSString has a reliable `-hash` method.
	return [[NSString stringWithFormat:@"%u%u%u%u%u%u%u%u", 
			 _borderComponents.topLeftCorner,
			 _borderComponents.topFill,
			 _borderComponents.topRightCorner,
			 _borderComponents.leftFill,
			 _borderComponents.rightFill,
			 _borderComponents.bottomLeftCorner,
			 _borderComponents.bottomFill,
			 _borderComponents.bottomRightCorner] hash];
}

#pragma mark - Description
- (NSString *)description {
	return [NSString stringWithFormat:@"<OCBorder: %u %u %u %u %u %u %u %u %u>",
			_borderComponents.topLeftCorner,
			_borderComponents.topFill,
			_borderComponents.topRightCorner,
			_borderComponents.leftFill,
			_borderComponents.rightFill,
			_borderComponents.bottomLeftCorner,
			_borderComponents.bottomFill,
			_borderComponents.bottomRightCorner];
}

@end