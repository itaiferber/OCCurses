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

#import <Foundation/Foundation.h>

/*!
 @class OCBorder
 @discussion OCBorder is a simple wrapper for a string representing a border around a window.
 ncurses borders are formatted in a special way (left fill, right fill, top fill, bottom fill, top
 left corner, top right corner, bottom left corner, bottom right corner), and the string passed to 
 an OCBorder must be formatted in the same way.
 */
@interface OCBorder : NSObject {
	NSString *_borderComponents;
}

#pragma mark Properties
@property (copy) NSString *borderComponents;
@property (readonly) unichar topLeftCorner;
@property (readonly) unichar topFill;
@property (readonly) unichar topRightCorner;
@property (readonly) unichar leftFill;
@property (readonly) unichar rightFill;
@property (readonly) unichar bottomLeftCorner;
@property (readonly) unichar bottomFill;
@property (readonly) unichar bottomRightCorner;


#pragma mark Initializers
/*!
 Creates a new border with the given component string.
 @param aString the component string
 @returns an autoreleased border object
 */
+ (id)borderWithComponentString:(NSString *)aString;

/*!
 Initializes a new border with the given component string.
 @param aString the component string
 @returns an initialized border object
 */
- (id)initWithComponentString:(NSString *)aString;

@end