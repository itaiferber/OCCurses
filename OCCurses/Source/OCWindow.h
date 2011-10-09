//
//  OCWindow.h
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
	NSString *_title;
	NSRect _frame;
	NSMutableArray *_subwindows;
	NSMutableSet *_attributes;
	OCBorder *_border;
	BOOL _keypadEnabled;
	
	WINDOW *_window;
	PANEL *_panel;
}

#pragma mark - Properties
@property (readonly) NSString *title;
@property (readonly) NSRect frame;

#pragma mark - Initializers
/*!
 Creates a new main window (representing stdscr) for the program to run with. This window is the
 root of the window hierarchy.
 @return the main window
 */
+ (id)mainWindow;

/*!
 Creates a new autoreleased window with a given title and frame (and a default parent window of 
 stdscr).
 @param theTitle the title to give the window (precondition: theTitle != nil)
 @param theFrame the frame to give the window
 @returns a new autoreleased window
 */
+ (id)windowWithTitle:(NSString *)theTitle frame:(NSRect)theFrame;

/*!
 Creates a new autoreleased window with a given title, frame, and parent window.
 @param theTitle the title to give the window (precondition: theTitle != nil)
 @param theFrame the frame to give the window
 @param theWindow the parent window to create a subwindow for
 @returns a new autoreleased window
 */
+ (id)windowWithTitle:(NSString *)theTitle frame:(NSRect)theFrame parentWindow:(OCWindow *)theWindow;

/*!
 Initializes a new autoreleased window with a given title and frame (and a default parent window of 
 stdscr).
 @param theTitle the title to give the window (precondition: theTitle != nil)
 @param theFrame the frame to give the window
 @returns a new initialized window
 */
- (id)initWithTitle:(NSString *)theTitle frame:(NSRect)theFrame;

/*!
 Initializes a new autoreleased window with a given title, frame, and parent window.
 @param theTitle the title to give the window (precondition: theTitle != nil)
 @param theFrame the frame to give the window
 @param theWindow the parent window to create a subwindow for
 @returns a new initialized window
 */
- (id)initWithTitle:(NSString *)theTitle frame:(NSRect)theFrame parentWindow:(OCWindow *)theWindow;


#pragma mark - Subwindow Methods
/*!
 Returns an array of subwindows belonging to the current window.
 */
- (NSArray *)subwindows;
 
/*!
 Adds a subwindow to the current window.
 @param theWindow the subwindow to add (precondition: theWindow != nil)
 */
- (void)addSubwindow:(OCWindow *)theWindow;

/*!
 Returns the subwindow at the given index.
 @param theIndex the index to retrieve (precondition: index < [_subwindows length])
 @returns the subwindow
 */
- (OCWindow *)subwindowAtIndex:(NSUInteger)theIndex;

/*!
 Performs a breadth-first search for a window with the given title in the window hierarchy stemming
 from this window, and returns it. Returns nil if there is no such titled window.
 @param theTitle the title of the subwindow to search for (precondition: theTitle != nil)
 @returns a subwindow with the given title
 */
- (OCWindow *)subwindowWithTitle:(NSString *)theTitle;

/*!
 Removes the given window from the window hierarchy completely (even if it appears multiple times)
 and destroys it.
 @param theWindow the subwindow to remove (precondition: theWindow != nil)
 */
- (void)removeSubwindow:(OCWindow *)theWindow;


#pragma mark - Window Property Methods
/*!
 Returns the location of the cursor in the window.
 @returns the location of the cursor
 */
- (NSPoint)cursorLocation;

/*!
 Returns the frame of the window as a formatted rectangle
 @returns the frame of the window
 */
- (NSRect)frame;

/*!
 Sets the frame of the window to the given rectangle. Resizes and moves as necessary.
 @param thePoint the frame to use (precondition: the frame is valid)
 @returns whether the operation was performed successfully
 */
- (BOOL)setFrame:(NSRect)theFrame;

/*!
 Moves the window to a new origin (the origin of ncurses windows is the top-left corner).
 @param thePoint the point to move the window to (precondition: the point is valid)
 @returns whether the operation was performed successfully
 */
- (BOOL)setFrameOrigin:(NSPoint)thePoint;


#pragma mark - Keypad Methods
/*!
 Returns whether a keypad is enabled for the window. Enabling a keypad for a window allows it
 to interpret unprintable keystrokes, such as function keys, arrow keys, the escape key, and so on.
 By default, a keypad is enabled for the window.
 @returns whether a keypad is enabled
 */
- (BOOL)isKeypadEnabled;

/*!
 Enables or disables a keypad for the window.
 @param theFlag whether to enable or disable the keypad
 */
- (void)setKeypadEnabled:(BOOL)theFlag;


#pragma mark - Attribute Methods
/*!
 Enables the given text attribute using wattron() and adds it to a list of enabled attributes.
 @param theAttribute the attribute to apply (precondition: theAttribute != nil)
 */
- (void)enableAttribute:(OCAttribute *)theAttribute;

/*!
 Disables the given textAttribute using wattroff() and removes it from a list of enabled attributes.
 @param theAttribute the attribute to remove (precondition: theAttribute != nil)
 */
- (void)disableAttribute:(OCAttribute *)theAttribute;

/*!
 Enables a set of attributes, calling -enableAttribute: using each one.
 @see enableAttribute for an explanation of how attributes are applied
 @param theSet the set of attributes to apply (precondition: theSet != nil)
 */
- (void)enableAttributes:(NSSet *)theSet;

/*!
 Disables a set of attributes, calling -disableAttribute: using each one.
 @see disableAttribute for an explanation of how attributes are removed
 @param theSet the set of attributes to remove (precondition: theSet != nil)
 */
- (void)disableAttributes:(NSSet *)theSet;

/*!
 Sets the given attributes using wattrset() (destroying the previous attribute configuration) and
 replaces the list of enabled attributes with the given one. Pass in nil to disable all attributes.
 @param theSet the set of attributes to set
 */
- (void)setAttributes:(NSSet *)theSet;

/*!
 Disables all attributes using watterset() and replaces the list of enabled attributes with an empty
 one.
 */
- (void)disableAllAttributes;


#pragma mark - Border Methods
/*!
 Returns the currently applied border (nil if no border is set).
 @returns the window's border
 */
- (OCBorder *)border;

/*!
 Applies a new border to the window (if theBorder is nil, it removes the border).
 @param theBorder the border to set
 */
- (void)setBorder:(OCBorder *)theBorder;


#pragma mark - Printing Methods
/*!
 Clears the window.
 */
- (void)clear;

/*!
 Refreshes the window for printing and synchronizes with other panels.
 */
- (void)refresh;

/*!
 Writes the given format to the window at the current cursor position, returning whether the
 operation was successful.
 @param theFormat the format to write (precondition: theFormat != nil)
 @returns whether writing succeeded
 */
- (BOOL)writeToWindow:(NSString *)theFormat, ... NS_FORMAT_FUNCTION(1, 2);

/*!
 Writes the given format to the window at the given location, moving the cursor to that location and
 returning whether the operation was successful.
 @param theLocation the location to write to (precondition: theLocation is valid)
 @param theFormat the format to write (precondition: theFormat != nil)
 @returns whether writing succeeded
 */
- (BOOL)writeToWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat, ... NS_FORMAT_FUNCTION(2, 3);

/*!
 Writes the given format and argument list to the window at the current cursor positiong, returning
 whether the operation was successful.
 @param theFormat the format to write (precondition: theFormat != nil)
 @param theList the argument list to use
 @returns whether writing succeeded
 */
- (BOOL)writeToWindow:(NSString *)theFormat arguments:(va_list)theList;

/*!
 Writes the given format and argument list to the window at the given location, moving the cursor to
 that location and returning whether the operation was successful.
 @param theLocation the location to write to (precondition: theLocation is valid)
 @param theFormat the format to write (precondition: theFormat != nil)
 @param theList the argument list to use
 @returns whether writing succeeded
 */
- (BOOL)writeToWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat arguments:(va_list)theList;


#pragma mark - Character Methods
/*!
 Returns a single keystroke from the user (if keypad() is enabled, this keystroke can be an extended
 one).
 @returns the key pressed
 */
- (OCKey)getKey;

/*!
 Returns a single keystroke from the user at a given location (if keypad() is enabled, this
 keystroke can be an extended one).
 @param theLocation the location to accept the key from (precondition: theLocation is valid)
 @returns the key pressed
 */
- (OCKey)getKeyFromLocation:(NSPoint)theLocation;

/*!
 Writes a character to the screen at the current cursor position.
 @param theCharacter the character to write
 @returns whether writing succeeded
 */
- (BOOL)writeCharacter:(OCCharacter)theCharacter;

/*!
 Writes a character to the screen at the given location, moving the cursor to that location.
 @param theCharacter the character to write
 @param theLocation the location to write to (precondition: theLocation is valid)
 @returns whether writing succeeded
 */
- (BOOL)writeCharacter:(OCCharacter)theCharacter atLocation:(NSPoint)theLocation;

#pragma mark - Input Methods
/*!
 Scans a string of characters from the window at the current cursor position. Returns nil if
 the user types in no input.
 @returns a string of characters the user has input
 */
- (NSString *)getString;

/*!
 Scans a string of characters from the window at the given cursor position. Returns nil if
 the user types in no input.
 @param theLocation the location to scan characters from
 @return a string of characters the user has input
 */
- (NSString *)getStringFromLocation:(NSPoint)theLocation;

#pragma mark - Scanning Methods
/*!
 Scans a format from the window at the current cursor position.
 @param theFormat the format to scan (precondition: theFormat != nil)
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindow:(NSString *)theFormat, ... NS_FORMAT_FUNCTION(1, 2);

/*!
 Scans a format from the window at the given location, moving the cursor to that location.
 @param theLocation the location to scan from (precondition: theLocation is valid)
 @param theFormat the format to scan (precondition: theFormat != nil)
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat, ... NS_FORMAT_FUNCTION(2, 3);

/*!
 Scans a format from the window at the current cursor position into the given argument list.
 @param theFormat the format to scan (precondition theFormat != nil)
 @param theList the argument list to scan to
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindow:(NSString *)theFormat arguments:(va_list)theList;

/*!
 Scans a format from the window at the given location, moving the cursor to that location, into the
 given argument list.
 @param theLocation the location to scan from (precondition: theLocation is valid)
 @param theFormat the format to scan (precondition: theFormat != nil)
 @param theList the argument list to scan to
 @returns whether scanning succeeded
 */
- (BOOL)scanFromWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat arguments:(va_list)theList;

@end
