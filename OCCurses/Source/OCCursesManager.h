//
//  OCCursesManager.h
//  OCCurses
//
//  Created by Itai Ferber on 3/3/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <curses.h>
#import "OCWindow.h"
#import "OCKey.h"

/*!
 @class OCCursesManager
 @discussion OCCursesManager is the top-level class used to initialize and manage ncurses. There is
 a shared manager that handles the starting and ending of ncurses, along with handing several common
 attributes commonly set at startup.
 
 At the initialization of the system, cbreak(), noecho(), keypad(), meta(), and nonl() are called as
 common default settings. Use the given methods to reapply settings as necessary.
 */
@interface OCCursesManager : NSObject {
	OCWindow *standardScreen;
}

#pragma mark Initializers
/*!
 Creates and returns a new shared ncurses manager. If one does not yet exist, a new manager is
 initialized, thereby starting ncurses.
 @returns a new autoreleased ncurses manager
 */
+ (id)sharedManager;

#pragma mark Properties
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
 Returns whether a keypad (keypad()) is enabled (enabling a keypad will allow the program to receive
 and interpret non-displaying keys such as arrow keys, function keys, etc.). By default, a keypad is
 enabled.
 @returns whether keypad() is enabled
 */
+ (BOOL)isKeypadEnabled;

/*!
 Enables or disables a keypad.
 @see isKeypadEnabled for an explanation of keypad
 @param aFlag whether to enable or disable a keypad
 */
+ (void)setKeypadEnabled:(BOOL)aFlag;

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
