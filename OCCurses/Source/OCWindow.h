//
//  OCWindow.h
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <panel.h>
#import "OCAttribute.h"
#import "OCBorder.h"
#import "OCCharacter.h"
#import "OCColorPair.h"
#import "OCKey.h"

/*!
 @class OCWindow
 @discussion OCWindow is the main powerhouse of the framework, representing an ncurses window and
 panel. OCWindows are organized in a tree heirarchy (much like views are in a graphical application),
 and are displayed on screen in the order they are created (using the behavior of ncurses panels).
 
 Windows have titles, frames, subwindows, enabled attributes, and borders. They can be written to
 and scanned from, and text attributes can be easily applied using the OCAttribute class.
 */
@interface OCWindow : NSObject {
	NSString *title;
	NSRect frame;
	NSMutableArray *subwindows;
	NSMutableSet *attributes;
	OCBorder *border;
	
	WINDOW *window;
	PANEL *panel;
}

#pragma mark Properties
@property (readonly) NSString *title;
@property (readonly) NSRect frame;
@property (readonly) OCBorder *border;

#pragma mark Initializers
/*!
 Creates a new main window (representing stdscr) for the program to run with. This window is the
 root of the window hierarchy.
 @return the main window
 */
+ (id)mainWindow;

/*!
 Creates a new autoreleased window with a given title and frame (and a default parent window of 
 stdscr).
 @param aTitle the title to give the window
 @param aFrame the frame to give the window
 @returns a new autoreleased window
 */
+ (id)windowWithTitle:(NSString *)aTitle frame:(NSRect)aFrame;

/*!
 Creates a new autoreleased window with a given title, frame, and parent window.
 @param aTitle the title to give the window
 @param aFrame the frame to give the window
 @param aWindow the parent window to create a subwindow for
 @returns a new autoreleased window
 */
+ (id)windowWithTitle:(NSString *)aTitle frame:(NSRect)aFrame parentWindow:(OCWindow *)aWindow;

/*!
 Initializes a new autoreleased window with a given title and frame (and a default parent window of 
 stdscr).
 @param aTitle the title to give the window
 @param aFrame the frame to give the window
 @returns a new initialized window
 */
- (id)initWithTitle:(NSString *)aTitle frame:(NSRect)aFrame;

/*!
 Initializes a new autoreleased window with a given title, frame, and parent window.
 @param aTitle the title to give the window
 @param aFrame the frame to give the window
 @param aWindow the parent window to create a subwindow for
 @returns a new initialized window
 */
- (id)initWithTitle:(NSString *)aTitle frame:(NSRect)aFrame parentWindow:(OCWindow *)aWindow;

#pragma mark Subwindow Methods
/*!
 Adds a subwindow to the current window.
 @param aWindow the subwindow to add
 */
- (void)addSubwindow:(OCWindow *)aWindow;

/*!
 Returns the subwindow at the given index.
 @param anIndex the index to retrieve (precondition: the index is valid)
 @returns the subwindow
 */
- (OCWindow *)subwindowAtIndex:(NSUInteger)anIndex;

/*!
 Performs a breadth-level search for a window with the given title in the window hierarchy stemming
 from this window, and returns it. Returns nil if there is no such titled window.
 @returns a subwindow with the given title
 */
- (OCWindow *)subwindowWithTitle:(NSString *)aTitle;

/*!
 Removes and destroys the given window from the window hierarchy.
 @param aWindow the subwindow to remove (precondition: aWindow is a subwindow of the current window)
 */
- (void)removeSubwindow:(OCWindow *)aWindow;

#pragma mark Window Property Methods
/*!
 Returns the frame of the window as a formatted rectangle
 @returns the frame of the window
 */
- (NSRect)frame;

/*!
 Sets the frame of the window to the given rectangle. Resizes and moves as necessary.
 @param aRect the frame to use (precondition: the frame is valid)
 @returns whether the operation was performed successfully
 */
- (BOOL)setFrame:(NSRect)aRect;

/*!
 Moves the window to a new origin (the origin of ncurses windows is the top-left corner).
 @param aPoint the point to move the window to (precondition: the point is valid)
 @returns whether the operation was performed successfully
 */
- (BOOL)setFrameOrigin:(NSPoint)aPoint;

#pragma mark Attribute Methods
/*!
 Enables the given text attribute using wattron() and adds it to a list of enabled attributes.
 @param anAttribute the attribute to apply
 */
- (void)enableAttribute:(OCAttribute *)anAttribute;

/*!
 Disables the given textAttribute using wattroff() and removes it from a list of enabled attributes.
 @param anAttribute the attribute to remove
 */
- (void)disableAttribute:(OCAttribute *)anAttribute;

/*!
 Enables a set of attributes, calling -enableAttribute: using each one.
 @see enableAttribute for an explanation of how attributes are applied
 @param aSet the set of attributes to apply
 */
- (void)enableAttributes:(NSSet *)aSet;

/*!
 Disables a set of attributes, calling -disableAttribute: using each one.
 @see disableAttribute for an explanation of how attributes are removed
 @param aSet the set of attributes to remove
 */
- (void)disableAttributes:(NSSet *)aSet;

/*!
 Sets the given attributes using wattrset() (destroying the previous attribute configuration) and
 replaces the list of enabled attributes with the given one.
 @param aSet the set of attributes to set
 */
- (void)setAttributes:(NSSet *)aSet;

/*!
 Disables all attributes using watterset() and replaces the list of enabled attributes with an empty
 one.
 */
- (void)disableAllAttributes;

#pragma mark Border Methods
/*!
 Returns the currently applied border (nil if no border is set).
 @returns the window's border
 */
- (OCBorder *)border;

/*!
 Applies a new border to the window (if aBorder is nil, it removes the border).
 @param aBorder the border to set
 */
- (void)setBorder:(OCBorder *)aBorder;

#pragma mark Printing Methods
/*!
 Writes the given format to the window at the current cursor position, returning whether the
 operation was successful.
 @param aFormat the format to write
 @returns whether writing succeeded
 */
- (BOOL)writeToWindow:(NSString *)aFormat, ... NS_FORMAT_FUNCTION(1, 2);

/*!
 Writes the given format to the window at the given location, moving the cursor to that location and
 returning whether the operation was successful.
 @param aLocation the location to write to
 @param aFormat the format to write
 @returns whether writing succeeded
 */
- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat, ... NS_FORMAT_FUNCTION(2, 3);

/*!
 Writes the given format and argument list to the window at the current cursor positiong, returning
 whether the operation was successful.
 @param aFormat the format to write
 @param aList the argument list to use
 @returns whether writing succeeded
 */
- (BOOL)writeToWindow:(NSString *)aFormat arguments:(va_list)aList;

/*!
 Writes the given format and argument list to the window at the given location, moving the cursor to
 that location and returning whether the operation was successful.
 @param aLocation the location to write to
 @param aFormat the format to write
 @param aList the argument list to use
 @returns whether writing succeeded
 */
- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList;

#pragma mark Character Methods
/*!
 Returns a single keystroke from the user (if keypad() is enabled, this keystroke can be an extended
 one).
 @returns the key pressed
 */
- (OCKey)getKey;

/*!
 Returns a single keystroke from the user at a given location (if keypad() is enabled, this
 keystroke can be an extended one).
 @returns the key pressed
 */
- (OCKey)getKeyFromLocation:(NSPoint)aLocation;

/*!
 Writes a character to the screen at the current cursor position.
 @param aCharacter the character to write
 @returns whether writing succeeded
 */
- (BOOL)writeCharacter:(OCCharacter)aCharacter;

/*!
 Writes a character to the screen at the given location, moving the cursor to that location.
 @param aLocation the location to write to
 @param aCharacter the character to write
 @returns whether writing succeeded
 */
- (BOOL)writeCharacterAtLocation:(NSPoint)aLocation character:(OCCharacter)aCharacter;

#pragma mark Scanning Methods
/*!
 Scans a format from the window at the current cursor position.
 @param aFormat the format to scan
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindow:(NSString *)aFormat, ... NS_FORMAT_FUNCTION(1, 2);

/*!
 Scans a format from the window at the given location, moving the cursor to that location.
 @param aLocation the location to scan from
 @param aFormat the format to scan
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat, ... NS_FORMAT_FUNCTION(2, 3);

/*!
 Scans a format from the window at the current cursor position into the given argument list.
 @param aFormat the format to scan
 @param aList the argument list to scan to
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindow:(NSString *)aFormat arguments:(va_list)aList;

/*!
 Scans a format from the window at the given location, moving the cursor to that location, into the
 given argument list.
 @param aLocation the location to scan from
 @param aFormat the format to scan
 @param aList the argument list to scan to
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList;

@end
