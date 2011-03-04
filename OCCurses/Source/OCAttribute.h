//
//  OCAttribute.h
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <curses.h>

/*!
 @typedef OCAttributeIdentifier
 @discussion A convenience identifier typedef used to control text attribute creation.
 */
typedef unsigned short OCAttributeIdentifier;

/*!
 @enum OCAttributeIdentifier
 @discussion A convenience enumeration used to create standard text attributes.
 */
extern enum OCAttributeIdentifier {
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
};

/*!
 @class OCAttribute
 @discussion OCAttribute is a  simple wrapper for text attribute identifiers, used to apply text
 attributes to text. Provided are the common text attributes provided by ncurses, with several
 cryptic ones left out.
 */
@interface OCAttribute : NSObject {
	OCAttributeIdentifier attributeIdentifier;
}

#pragma mark Properties
@property (readonly) OCAttributeIdentifier attributeIdentifier;

#pragma mark Initializers
/*!
 Creates a new text attribute with the given identifier.
 @param anIdentifier the identifier to use
 @returns an autoreleased text attribute object
 */
+ (id)attributeWithAttributeIdentifier:(OCAttributeIdentifier)anIdentifier;

/*!
 Initializes a new text attribute with the given identifier.
 @param anIdentifier the identifier to use
 @returns an initialized text attribute object
 */
- (id)initWithAttributeIdentifier:(OCAttributeIdentifier)anIdentifier;

@end
