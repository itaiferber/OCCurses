//
//  OCColorPair.h
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
#import "OCAttribute.h"
#import "OCColor.h"

/*!
 @class OCColorPair
 @discussion OCColorPair is a wrapper for color pairs that is meant to be used as a text attribute 
 (hence the inheritance). Color pairs have an identifier (starting at 1 and going upward - generated
 using a static identifier variable incremented every time a color is initialized), a foreground 
 color, and a background color. Once color pairs are initialized, they can be applied like any other
 text attribute using their identifiers.
 */
@interface OCColorPair : OCAttribute {
	OCColor *_foregroundColor;
	OCColor *_backgroundColor;
}

#pragma mark Properties
@property (readonly) OCColor *foregroundColor;
@property (readonly) OCColor *backgroundColor;


#pragma mark Initializers
/*!
 Creates a new color pair with a statically created identifier.
 @param theForeground the foreground color to use (precondition: aForeground != nil)
 @param theBackground the background color to use (precondition: aBackground != nil)
 @returns an autoreleased color pair object
 */
+ (id)colorPairWithForegroundColor:(OCColor *)theForeground backgroundColor:(OCColor *)theBackground;

/*!
 Initializes a new color pair with a statically created identifier.
 @param theForeground the foreground color to use (precondition: aForeground != nil)
 @param theBackground the background color to use (precondition: aBackground != nil)
 @returns an initialized color pair object
 */
- (id)initWithForegroundColor:(OCColor *)theForeground backgroundColor:(OCColor *)theBackground;

@end