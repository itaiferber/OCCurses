//
//  OCColor.h
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
 @enum OCColorIdentifier
 @discussion A convenience enumeration for ensuring only specific color definitions.
 ncurses colors are integers between 0 and 7.
 */
typedef enum {
	OCColorBlack = COLOR_BLACK,
	OCColorRed = COLOR_RED,
	OCColorGreen = COLOR_GREEN,
	OCColorYellow = COLOR_YELLOW,
	OCColorBlue = COLOR_BLUE,
	OCColorMagenta = COLOR_MAGENTA,
	OCColorCyan = COLOR_CYAN,
	OCColorWhite = COLOR_WHITE
} OCColorIdentifier;

/*!
 @class OCColor
 @discussion OCColor is a simple wrapper for color identifiers. It offers convenience methods for
 creating preset colors, and integrates with OCColorPair to create color attributes that can be
 applied to text.
 */
@interface OCColor : NSObject {
	OCColorIdentifier _colorIdentifier;
}

#pragma mark Properties
@property (readonly) OCColorIdentifier colorIdentifier;

#pragma mark Initializers
/*!
 Creates a new black color object.
 @returns an autoreleased black color object
 */
+ (id)blackColor;

/*!
 Creates a new red color object.
 @returns an autoreleased red color object
 */
+ (id)redColor;

/*!
 Creates a new green color object.
 @returns an autoreleased green color object
 */
+ (id)greenColor;

/*!
 Creates a new yellow color object.
 @returns an autoreleased yellow color object
 */
+ (id)yellowColor;

/*!
 Creates a new blue color object.
 @returns an autoreleased blue color object
 */
+ (id)blueColor;

/*!
 Creates a new magenta color object.
 @returns an autoreleased magenta color object
 */
+ (id)magentaColor;

/*!
 Creates a new cyan color object.
 @returns an autoreleased cyan color object
 */
+ (id)cyanColor;

/*!
 Creates a new white color object.
 @returns an autoreleased white color object
 */
+ (id)whiteColor;

@end