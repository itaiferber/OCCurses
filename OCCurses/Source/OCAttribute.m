//
//  OCAttribute.m
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

#import "OCAttribute.h"


@implementation OCAttribute

#pragma mark - Synthesis
@synthesize attributeIdentifier = _attributeIdentifier;

#pragma mark - Initialization
+ (id)attributeWithAttributeIdentifier:(OCAttributeIdentifier)theIdentifier {
	return [[[self alloc] initWithAttributeIdentifier:theIdentifier] autorelease];
}

- (id)initWithAttributeIdentifier:(OCAttributeIdentifier)theIdentifier {
	if ((self = [super init])) {
		_attributeIdentifier = theIdentifier;
	}
	
	return self;
}

#pragma mark - Equality Testing
- (BOOL)isEqual:(id)object {
	// Hashes are unique; no need to further compare equality.
	return [object isKindOfClass:[self class]] && [object hash] == [self hash];
}

- (NSUInteger)hash {
	return _attributeIdentifier;
}

#pragma mark - Description
- (NSString *)description {
	NSString *attributeDescription;
	switch (_attributeIdentifier) {
		case OCAttributeNormal:
			attributeDescription = @"OCAttributeNormal";
			break;
		case OCAttributeStandout:
			attributeDescription = @"OCAttributeStandout";
			break;
		case OCAttributeUnderline:
			attributeDescription = @"OCAttributeUnderline";
			break;
		case OCAttributeReverse:
			attributeDescription = @"OCAttributeReverse";
			break;
		case OCAttributeBlink:
			attributeDescription = @"OCAttributeBlink";
			break;
		case OCAttributeDim:
			attributeDescription = @"OCAttributeDim";
			break;
		case OCAttributeAlternativeCharacterSet:
			attributeDescription = @"OCAttributeAlternateCharacterSet";
			break;
		case OCAttributeInvisible:
			attributeDescription = @"OCAttributeInvisible";
			break;
		case OCAttributeProtected:
			attributeDescription = @"OCAttributeProtected";
			break;
		default:
			attributeDescription = nil;
			break;
	}
	
	return [NSString stringWithFormat:@"<OCAttribute: %@>", attributeDescription];
}

@end