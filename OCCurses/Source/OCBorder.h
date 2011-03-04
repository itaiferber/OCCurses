//
//  OCBorder.h
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class OCBorder
 @discussion OCBorder is a simple wrapper for a string representing a border around a window.
 ncurses borders are formatted in a special way (left fill, right fill, top fill, bottom fill, top
 left corner, top right corner, bottom left corner, bottom right corner), and the string passed to 
 an OCBorder must be formatted in the same way.
 */
@interface OCBorder : NSObject {
	NSString *borderComponents;
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
