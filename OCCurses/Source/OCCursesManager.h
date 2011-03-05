//
//  OCCursesManager.h
//  OCCurses
//
//  Created by Itai Ferber on 3/3/11.
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
#import "OCWindow.h"
#import "OCKey.h"

/*!
 @class OCCursesManager
 @discussion OCCursesManager is the top-level class used to initialize and manage ncurses.
 Before main() is called, OCCursesManager initializes curses mode and enables default settings. 
 After main() exits, curses mode is automatically exited, and the terminal returns to normal.
 
 At the initialization of the system, noraw(), cbreak() and noecho() are called as common default
 settings. Use the given methods to reapply settings as necessary.
 */
@interface OCCursesManager : NSObject {}

#pragma mark States
/*!
 Returns whether the terminal is currently in curses mode (terminals can temporarily exit curses
 mode and reenter later using def_prog_mode() and reset_prog_mode()).
 @returns whether the terminal is in curses mode
 */
+ (BOOL)isInCursesMode;

/*!
 If the terminal is in curses mode, it temporarily returns to the default TTY mode.
 */
+ (void)pauseCursesMode;

/*!
 If the terminal is in the default TTY mode, it returns to curses mode.
 */
+ (void)resumeCursesMode;


#pragma mark Properties
/*!
 Returns whether the current terminal has color capabilities or not. By default, color support is
 turned off.
 @returns whether colors can be used
 */
+ (BOOL)hasColors;

/*!
 Starts colors on the current terminal. This will usually set the color scheme to something other
 than the default. Unfortunately, ncurses has no support for determining the default colors set for
 the terminal.
 */
+ (void)startColors;

/*!
 Returns whether the current terminal accepts the given key as a valid keystroke.
 @param aKey the key to check
 @returns whether the key is accepted
 */
+ (BOOL)hasKey:(OCKey)aKey;

/*!
 Returns whether raw character mode (raw()) is enabled (enabling this mode causes the terminal to 
 pass all keystrokes to the program immediately for processing, regardless of their function - 
 including Ctrl-Z and Ctrl-C). By default, raw character mode is disabled.
 @returns whether raw() is enabled
 */
+ (BOOL)isRawEnabled;

/*!
 Enables or disables raw character mode.
 @see isRawEnabled for an explanation of raw character mode
 @param aFlag whether to enable or disable raw character mode
 */
+ (void)setRawEnabled:(BOOL)aFlag;

/*!
 Returns whether character break mode (cbreak()) is enabled (enabling this mode causes the terminal
 to pass on all characters to the program immediately, interpreting keystrokes such as Ctrl-Z and
 Ctrl-C to determine its own function). By default, character break mode is enabled. Character
 break mode overrides raw character mode, and is inherited by the current state of the terminal, 
 which may or may not already be in the mode.
 @returns whether cbreak() is enabled
 */
+ (BOOL)isCharacterBreakEnabled;

/*!
 Enables or disables character break mode.
 @see isCharacterBreakEnabled for an explanation of character break mode
 @param aFlag whether to enable or disable character break mode
 */
+ (void)setCharacterBreakEnabled:(BOOL)aFlag;

/*!
 Returns whether echo mode (echo()) is enabled (enabling this mode causes the terminal to display
 every key the user types in - this is the default mode for every terminal - but disabling this mode
 enables the program to accept user input without affecting the user interface). By default, echo
 mode is disabled.
 @returns whether echo() is enabled
 */
+ (BOOL)isEchoEnabled;

/*!
 Enables or disables echo mode.
 @see isEchoEnabled for an explanation of echo mode
 @param aFlag whether to enable or disable echo mode
 */
+ (void)setEchoEnabled:(BOOL)aFlag;

/*!
 Returns whether a half delay (halfdelay()) is enabled (enabling a half delay will cause the program
 to pause for a given number of milliseconds before accepting input for a -getCharacter-type call, 
 and if no input is given, the function returns ERR - useful for including a time limit on entering 
 input). By default, half delays are disabled.
 @returns the half delay enabled (0 if none)
 */
+ (unsigned int)halfDelay;

/*!
 Enables or disables a half delay.
 @see halfDelay for an explanation of half delays
 @param aDelay the delay to set (0 to disable)
 */
+ (void)setHalfDelay:(unsigned int)aDelay;

@end
