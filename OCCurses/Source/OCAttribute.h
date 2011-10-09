//
//  OCAttribute.h
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

#import <Foundation/Foundation.h>
#include <curses.h>

/*!
 @enum OCAttributeIdentifier
 @discussion A convenience enumeration used to create standard text attributes.
 */
typedef enum {
	OCAttributeNormal = A_NORMAL,
	OCAttributeStandout = A_STANDOUT,
	OCAttributeUnderline = A_UNDERLINE,
	OCAttributeReverse = A_REVERSE,
	OCAttributeBlink = A_BLINK,
	OCAttributeDim = A_DIM,
	OCAttributeBold = A_BOLD,
	OCAttributeAlternativeCharacterSet = A_ALTCHARSET,
	OCAttributeInvisible = A_INVIS,
	OCAttributeProtected = A_PROTECT
} OCAttributeIdentifier;

/*!
 @class OCAttribute
 @discussion OCAttribute is a  simple wrapper for text attribute identifiers, used to apply text
 attributes to text. Provided are the common text attributes provided by ncurses, with several
 cryptic ones left out.
 */
@interface OCAttribute : NSObject {
	OCAttributeIdentifier _attributeIdentifier;
}

#pragma mark Properties
@property (readonly) OCAttributeIdentifier attributeIdentifier;


#pragma mark Initializers
/*!
 Creates a new text attribute with the given identifier.
 @param theIdentifier the identifier to use
 @returns an autoreleased text attribute object
 */
+ (id)attributeWithAttributeIdentifier:(OCAttributeIdentifier)theIdentifier;

/*!
 Initializes a new text attribute with the given identifier.
 @param theIdentifier the identifier to use
 @returns an initialized text attribute object
 */
- (id)initWithAttributeIdentifier:(OCAttributeIdentifier)theIdentifier;

@end