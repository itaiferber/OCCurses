//
//  OCBorder.h
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

/*!
 @struct OCBorderComponents
 @discussion A convenience structure for bundling border components necessitated by working with
 special characters.
 */
typedef struct {
	unsigned int topLeftCorner;
	unsigned int topFill;
	unsigned int topRightCorner;
	unsigned int leftFill;
	unsigned int rightFill;
	unsigned int bottomLeftCorner;
	unsigned int bottomFill;
	unsigned int bottomRightCorner;
} OCBorderComponents;

/*!
 Creates a new component structure from the given string. Because using strings results in a loss
 of information, this is not safe for use with special characters (all special characters created
 within the string will revert to their 'default' form; e.g. OCCharacterUpperLeftCorner -> 'k').
 
 The string must be formatted in the following order: Top Left Corner, Top Border, Top Right Corner,
 Left Border, Right Border, Bottom Left Corner, Bottom Border, Bottom Right Corner.
 @param string the string to create the components from (precondition: string != nil)
 @returns a newly created border components structure
 */
extern OCBorderComponents OCBorderComponentsFromString (NSString *string);

/*!
 Creates a new component structure from the given integer array. This is safe for use with special
 characters.
 The array must be formatted in the following order: Top Left Corner, Top Border, Top Right Corner,
 Left Border, Right Border, Bottom Left Corner, Bottom Border, Bottom Right Corner.
 @param array the array of integers (characters) to use (precondition: array != NULL &&
 sizeof(array) / sizeof(typeof(array[0])) == 8)
 */
extern OCBorderComponents OCBorderComponentsFromArray (const unsigned int *array);

/*!
 A convenience function that compares two border component structures for equality.
 @param first the first border component structure
 @param second the second border component structure
 @returns whether the two component structures are equal
 */
extern BOOL OCEqualBorderComponents (OCBorderComponents first, OCBorderComponents second);

#import <Foundation/Foundation.h>

/*!
 @class OCBorder
 @discussion OCBorder is a simple wrapper for a string representing a border around a window.
 ncurses borders are formatted in a special way (left fill, right fill, top fill, bottom fill, top
 left corner, top right corner, bottom left corner, bottom right corner), and the string passed to 
 an OCBorder must be formatted in the same way.
 */
@interface OCBorder : NSObject {
	OCBorderComponents _borderComponents;
}

#pragma mark Properties
@property (readonly) unsigned int topLeftCorner;
@property (readonly) unsigned int topFill;
@property (readonly) unsigned int topRightCorner;
@property (readonly) unsigned int leftFill;
@property (readonly) unsigned int rightFill;
@property (readonly) unsigned int bottomLeftCorner;
@property (readonly) unsigned int bottomFill;
@property (readonly) unsigned int bottomRightCorner;


#pragma mark Initializers
/*!
 Creates a new border with the given component string. Since NSString stores characters in unichar
 format, this constructor is not safe for use with special OCCharacters (OCCharacterDiamond, for
 instance). They will get overridden by their default form (OCCharacterUpperLeftCorner -> 'k').
 @see OCBorderComponentsFromString for string formatting instructions.
 @param theString the component string (precondition: aString != nil && [aString length] == 8)
 @returns an autoreleased border object
 */
+ (id)borderWithComponentString:(NSString *)theString;

/*!
 Creates a new border with the given components. This is safe for use with special OCCharacters.
 @param theComponents the border components to use
 @returns an autoreleased border object
 */
+ (id)borderWithComponents:(OCBorderComponents)theComponents;

/*!
 Initializes a new border with the given component string. Since NSString stores characters in 
 unichar format, this constructor is not safe for use with special OCCharacters (OCCharacterDiamond,
 for instance). They will get overridden by their default form (OCCharacterUpperLeftCorner -> 'k').
 @see OCBorderComponentsFromString for string formatting instructions.
 @param theString the component string (precondition: aString != nil && [aString length] == 8)
 @returns an initialized border object
 */
- (id)initWithComponentString:(NSString *)theString;

/*!
 Initializes a new border with the given components. This is safe for use with special OCCharacters.
 @param theComponents the border components to use
 @returns an initialized border object
 */
- (id)initWithComponents:(OCBorderComponents)theComponents;

@end