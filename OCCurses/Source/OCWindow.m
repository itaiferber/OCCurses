//
//  OCWindow.m
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

#import "OCWindow.h"

#define EVALUATE_WITH_ARGUMENT_LIST(format, argumentList, statement, returnType) va_list argumentList; \
																				 va_start(argumentList, format); \
																				 returnType result = statement; \
																				 va_end(argumentList); \
																				 return result;
#define UPDATE_PANELS update_panels(), doupdate()

@implementation OCWindow

#pragma mark - Synthesis
@synthesize title = _title;

#pragma mark - Initialization
static OCWindow *mainWindow = nil;
+ (id)mainWindow {
	static dispatch_once_t predicate;	
	dispatch_once(&predicate, ^{
		mainWindow = [[OCWindow alloc] init];
		mainWindow->_title = nil;
		mainWindow->_frame = (NSRect){0, 0, 0, 0};
		mainWindow->_subwindows = [[NSMutableArray alloc] init];
		mainWindow->_window = stdscr;
		mainWindow->_panel = new_panel(stdscr);
	});
	
	return mainWindow;
}

+ (id)windowWithTitle:(NSString *)theTitle frame:(NSRect)theFrame {
	return [[self alloc] initWithTitle:theTitle frame:theFrame];
}

+ (id)windowWithTitle:(NSString *)theTitle frame:(NSRect)theFrame parentWindow:(OCWindow *)theWindow {
	return [[self alloc] initWithTitle:theTitle frame:theFrame parentWindow:theWindow];
}

- (id)initWithTitle:(NSString *)theTitle frame:(NSRect)theFrame {
	if (!theTitle) return nil;
	if ((self = [super init])) {
		_window = newwin((int)_frame.size.height, (int)_frame.size.width, (int)_frame.origin.y, (int)_frame.origin.x);
		if (_window != NULL) {
			_title = [theTitle copy];
			_frame = theFrame;
			_subwindows = [[NSMutableArray alloc] init];
			_attributes = [[NSMutableSet alloc] init];
			_border = nil;
			
			keypad(_window, TRUE);
			_keypadEnabled = YES;
			
			_panel = new_panel(_window);
			[mainWindow addSubwindow:self];
			UPDATE_PANELS;
		} else {
			return nil;
		}
	}
	
	return self;
}

- (id)initWithTitle:(NSString *)theTitle frame:(NSRect)theFrame parentWindow:(OCWindow *)theWindow {
	if (!theTitle) return nil;
	if (!theWindow) return [self initWithTitle:theTitle frame:theFrame];
	if ((self = [super init])) {
		_window = newwin((int)_frame.size.height, (int)_frame.size.width, (int)_frame.origin.y, (int)_frame.origin.x);
		if (_window != NULL) {
			_title = [theTitle copy];
			_frame = theFrame;
			_subwindows = [[NSMutableArray alloc] init];
			_attributes = [[NSMutableSet alloc] init];
			_border = nil;
			
			keypad(_window, TRUE);
			_keypadEnabled = YES;
		
			_panel = new_panel(_window);
			[theWindow addSubwindow:self];
			UPDATE_PANELS;
		} else {
			self = nil;
		}
	}
	
	return self;
}

#pragma mark - Deallocation
- (void)dealloc {
	delwin(_window);
	del_panel(_panel);
}

#pragma mark - Subwindow Methods
- (NSArray *)subwindows {
	return _subwindows;
}

- (void)addSubwindow:(OCWindow *)theWindow {
	[_subwindows addObject:theWindow];
}

- (OCWindow *)subwindowAtIndex:(NSUInteger)anIndex {
	return [_subwindows objectAtIndex:anIndex];
}

- (OCWindow *)subwindowWithTitle:(NSString *)theTitle {
	if (!theTitle) return nil;
	for (OCWindow *subwindow in _subwindows) {
		if ([subwindow.title isEqualToString:theTitle]) {
			return subwindow;
		}
	}
	
	for (OCWindow *subwindow in _subwindows) {
		OCWindow *theWindow = [subwindow subwindowWithTitle:theTitle];
		if (theWindow) {
			return theWindow;
		}
	}
	
	return nil;
}

- (void)removeSubwindow:(OCWindow *)theWindow {
	if (!theWindow) return;
	[_subwindows removeObject:theWindow];
	for (OCWindow *subwindow in _subwindows) {
		[subwindow->_subwindows removeObject:theWindow];
	}
}

#pragma mark - Window Property Methods
- (NSPoint)cursorLocation {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return (NSPoint){xCoordinate, yCoordinate};
}

- (NSRect)frame {
	return _frame;
}

- (BOOL)setFrame:(NSRect)theRect {
	WINDOW *newWindow = newwin((int)theRect.size.height, (int)theRect.size.width, (int)theRect.origin.y, (int)theRect.origin.x);
	if (newWindow != NULL && mvwin(_window, (int)theRect.origin.y, (int)theRect.origin.x) == OK) {
		overwrite(_window, newWindow);
		replace_panel(_panel, newWindow);
		delwin(_window);
		_window = newWindow;
	}
	
	return NO;
}

- (BOOL)setFrameOrigin:(NSPoint)thePoint {
	int result = move_panel(_panel, thePoint.y, thePoint.x);
	if (result == OK) {
		_frame.origin.x = thePoint.x;
		_frame.origin.y = thePoint.y;
	}
	
	UPDATE_PANELS;
	return result == OK;
}

#pragma mark - Keypad Methods
- (BOOL)isKeypadEnabled {
	return _keypadEnabled;
}

- (void)setKeypadEnabled:(BOOL)theFlag {
	keypad(_window, theFlag ? TRUE : FALSE);
	_keypadEnabled = theFlag;
}

#pragma mark -Attribute Methods
- (void)enableAttribute:(OCAttribute *)theAttribute {
	if (!theAttribute) return;
	wattron(_window, [theAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(theAttribute.attributeIdentifier) : theAttribute.attributeIdentifier);
	[_attributes addObject:theAttribute];
}

- (void)disableAttribute:(OCAttribute *)theAttribute {
	if (!theAttribute) return;
	wattroff(_window, [theAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(theAttribute.attributeIdentifier) : theAttribute.attributeIdentifier);
	[_attributes removeObject:theAttribute];
}

- (void)enableAttributes:(NSSet *)theSet {
	if (!theSet) return;
	for (OCAttribute *attribute in theSet) {
		[self enableAttribute:attribute];
	}
}

- (void)disableAttributes:(NSSet *)theSet {
	if (!theSet) return;
	for (OCAttribute *attribute in theSet) {
		[self disableAttribute:attribute];
	}
}

- (void)setAttributes:(NSSet *)theSet {
	unsigned int attributeSum = 0;
	for (OCAttribute *attribute in theSet) {
		attributeSum |= attribute.attributeIdentifier;
	}
	
	wattrset(_window, attributeSum);
	_attributes = [theSet copy];
}

- (void)disableAllAttributes {
	wattrset(_window, OCAttributeNormal);
	_attributes = [[NSMutableSet alloc] init];
}

#pragma mark -Border Methods
- (OCBorder *)border {
	return _border;
}

- (void)setBorder:(OCBorder *)theBorder {
	if (_border != theBorder) {
		if (theBorder) {
			wborder(_window, theBorder.leftFill, theBorder.rightFill, theBorder.topFill, theBorder.bottomFill, theBorder.topLeftCorner, theBorder.topRightCorner, theBorder.bottomLeftCorner, theBorder.bottomRightCorner);
		} else {
			wborder(_window, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
		}
		
		_border = theBorder;
		[self refresh];
	}
}

#pragma mark - Printing Methods
- (void)clear {
	wclear(_window);
	[self refresh];
}

- (void)refresh {
	wrefresh(_window);
	UPDATE_PANELS;
}

- (BOOL)writeToWindow:(NSString *)theFormat, ... {
	if (!theFormat) return NO;
	EVALUATE_WITH_ARGUMENT_LIST(theFormat, aList, [self writeToWindow:theFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat, ... {
	if (!theFormat) return NO;
	EVALUATE_WITH_ARGUMENT_LIST(theFormat, aList, [self writeToWindowAtLocation:theLocation format:theFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindow:(NSString *)theFormat arguments:(va_list)aList {
	if (!theFormat) return NO;
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self writeToWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:theFormat arguments:aList];
}

- (BOOL)writeToWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat arguments:(va_list)aList {
	if (!theFormat) return NO;
	NSString *output = [[NSString alloc] initWithFormat:theFormat arguments:aList];
	int result = mvwprintw(_window, theLocation.y, theLocation.x, [output UTF8String]);
	
	return result == OK;
}

#pragma mark - Character Methods
- (OCKey)getKey {
	return wgetch(_window);
}
- (OCKey)getKeyFromLocation:(NSPoint)theLocation {
	return mvwgetch(_window, theLocation.y, theLocation.x);
}

- (BOOL)writeCharacter:(OCCharacter)theCharacter {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self writeCharacter:theCharacter atLocation:(NSPoint){xCoordinate, yCoordinate}];
}

- (BOOL)writeCharacter:(OCCharacter)theCharacter atLocation:(NSPoint)theLocation {
	return mvwaddch(_window, theLocation.y, theLocation.x, theCharacter) == OK;
}

#pragma mark - Input Methods
- (NSString *)getString {
	NSMutableString *string = nil;
	while (YES) {
		NSInteger character = wgetch(_window);
		if (character == ERR || character == '\n' || character == EOF) break;
		if (!string) string = [NSMutableString string];
		[string appendFormat:@"%c", character];
	}
	
	return string;
}

- (NSString *)getStringFromLocation:(NSPoint)theLocation {
	if (wmove(_window, theLocation.y, theLocation.x) == ERR) return nil;
	return [self getString];
}

#pragma mark - Scanning Methods
- (BOOL)scanFromWindow:(NSString *)theFormat, ... {
	if (!theFormat) return NO;
	EVALUATE_WITH_ARGUMENT_LIST(theFormat, aList, [self scanFromWindow:theFormat arguments:aList], BOOL);
}

- (BOOL)scanFromWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat, ... {
	if (!theFormat) return NO;
	EVALUATE_WITH_ARGUMENT_LIST(theFormat, aList, [self scanFromWindowAtLocation:theLocation format:theFormat arguments:aList], BOOL);
}

- (BOOL)scanFromWindow:(NSString *)theFormat arguments:(va_list)aList {
	if (!theFormat) return NO;
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self scanFromWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:theFormat arguments:aList];
}

- (BOOL)scanFromWindowAtLocation:(NSPoint)theLocation format:(NSString *)theFormat arguments:(va_list)aList {
	if (!theFormat) return NO;
	int result = wmove(_window, theLocation.y, theLocation.x);
	if (result == OK) {
		result = vwscanw(_window, (char *)[theFormat UTF8String], aList);
	}
	
	return result == OK;
}

#pragma mark - Equality Testing
- (BOOL)isEqual:(id)object {
	if (!([object isKindOfClass:[self class]] && [object hash] == [self hash])) return NO;
	OCWindow *window = (OCWindow *)object;

	BOOL isEqual = YES;
	isEqual &= [window.title isEqualToString:_title];
	isEqual &= NSEqualRects(window->_frame, _frame);
	isEqual &= [window->_subwindows isEqual:_subwindows];
	isEqual &= [window->_attributes isEqual:_attributes];
	isEqual &= [window->_border isEqual:_border];
	isEqual &= window->_keypadEnabled == _keypadEnabled;
	isEqual &= window->_window == _window;
	isEqual &= window->_panel == _panel;
	return isEqual ;
}

- (NSUInteger)hash {
	// Produces a fairly distinctive hash. Both objects have reliable `-hash` methods.
	return [_title hash] * [_border hash];
}

#pragma mark - Description
- (NSString *)description {
	return [NSString stringWithFormat:@"<OCWindow: %@, %@>", _title, NSStringFromRect(_frame)];
}

@end