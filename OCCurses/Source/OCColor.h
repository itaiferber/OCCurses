//
//  OCColor.h
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <curses.h>

/*!
 @typedef OCColorIdentifier
 @discussion A convenience typedef for ensuring only specific color identifiers.
 ncurses colors are integers between 0 and 7.
 */
typedef unsigned short OCColorIdentifier;

/*!
 @enum OCColorIdentifier
 @discussion A convenience enumeration for ensuring only specific color definitions.
 ncurses colors are integers between 0 and 7.
 */
extern enum OCColorIdentifier {
	OCColorBlack = COLOR_BLACK,
	OCColorRed = COLOR_RED,
	OCColorGreen = COLOR_GREEN,
	OCColorYellow = COLOR_YELLOW,
	OCColorBlue = COLOR_BLUE,
	OCColorMagenta = COLOR_MAGENTA,
	OCColorCyan = COLOR_CYAN,
	OCColorWhite = COLOR_WHITE
};

/*!
 @class OCColor
 @discussion OCColor is a simple wrapper for color identifiers. It offers convenience methods for
 creating preset colors, and integrates with OCColorPair to create color attributes that can be
 applied to text.
 */
@interface OCColor : NSObject {
	OCColorIdentifier colorIdentifier;
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
