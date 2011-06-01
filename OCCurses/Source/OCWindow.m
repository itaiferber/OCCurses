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

+ (id)windowWithTitle:(NSString *)aTitle frame:(NSRect)aFrame {
	return [[[self alloc] initWithTitle:aTitle frame:aFrame] autorelease];
}

+ (id)windowWithTitle:(NSString *)aTitle frame:(NSRect)aFrame parentWindow:(OCWindow *)aWindow {
	return [[[self alloc] initWithTitle:aTitle frame:aFrame parentWindow:aWindow] autorelease];
}

- (id)initWithTitle:(NSString *)aTitle frame:(NSRect)aFrame {
	if ((self = [super init])) {
		_window = newwin((int)_frame.size.height, (int)_frame.size.width, (int)_frame.origin.y, (int)_frame.origin.x);
		if (_window != NULL) {
			_title = [aTitle copy];
			_frame = aFrame;
			_subwindows = [[NSMutableArray alloc] init];
			_attributes = [[NSMutableSet alloc] init];
			_border = nil;
			
			keypad(_window, TRUE);
			_keypadEnabled = YES;
			
			_panel = new_panel(_window);
			[mainWindow addSubwindow:self];
			UPDATE_PANELS;
		} else {
			[self release];
			return nil;
		}
	}
	
	return self;
}

- (id)initWithTitle:(NSString *)aTitle frame:(NSRect)aFrame parentWindow:(OCWindow *)aWindow {
	if (!aWindow) return [self initWithTitle:aTitle frame:aFrame];
	if ((self = [super init])) {
		_window = newwin((int)_frame.size.height, (int)_frame.size.width, (int)_frame.origin.y, (int)_frame.origin.x);
		if (_window != NULL) {
			_title = [aTitle copy];
			_frame = aFrame;
			_subwindows = [[NSMutableArray alloc] init];
			_attributes = [[NSMutableSet alloc] init];
			_border = nil;
			
			keypad(_window, TRUE);
			_keypadEnabled = YES;
		
			_panel = new_panel(_window);
			[aWindow addSubwindow:self];
			UPDATE_PANELS;
		} else {
			[self release], self = nil;
		}
	}
	
	return self;
}

#pragma mark -
#pragma mark Deallocation
- (void)dealloc {
	[_title release], _title = nil;
	[_subwindows release], _subwindows = nil;
	[_attributes release], _attributes = nil;
	[_border release], _border = nil;
	
	delwin(_window);
	del_panel(_panel);
	[super dealloc];
}

#pragma mark -
#pragma mark Subwindow Methods
- (void)addSubwindow:(OCWindow *)aWindow {
	[_subwindows addObject:aWindow];
}

- (OCWindow *)subwindowAtIndex:(NSUInteger)anIndex {
	return [_subwindows objectAtIndex:anIndex];
}

- (OCWindow *)subwindowWithTitle:(NSString *)aTitle {
	for (OCWindow *subwindow in _subwindows) {
		if ([subwindow.title isEqualToString:aTitle]) {
			return subwindow;
		}
	}
	
	for (OCWindow *subwindow in _subwindows) {
		OCWindow *theWindow = [subwindow subwindowWithTitle:aTitle];
		if (theWindow) {
			return theWindow;
		}
	}
	
	return nil;
}

- (void)removeSubwindow:(OCWindow *)aWindow {
	[_subwindows removeObject:aWindow];
}

#pragma mark -
#pragma mark Window Property Methods
- (NSPoint)cursorLocation {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return (NSPoint){xCoordinate, yCoordinate};
}

- (NSRect)frame {
	return _frame;
}

- (BOOL)setFrame:(NSRect)aRect {
	WINDOW *newWindow = newwin((int)aRect.size.height, (int)aRect.size.width, (int)aRect.origin.y, (int)aRect.origin.x);
	if (newWindow != NULL && mvwin(_window, (int)aRect.origin.y, (int)aRect.origin.x) == OK) {
		overwrite(_window, newWindow);
		replace_panel(_panel, newWindow);
		delwin(_window);
		_window = newWindow;
	}
	
	return NO;
}

- (BOOL)setFrameOrigin:(NSPoint)aPoint {
	int result = move_panel(_panel, aPoint.y, aPoint.x);
	if (result == OK) {
		_frame.origin.x = aPoint.x;
		_frame.origin.y = aPoint.y;
	}
	
	UPDATE_PANELS;
	return result == OK;
}

#pragma mark -
#pragma mark Keypad Methods
- (BOOL)isKeypadEnabled {
	return _keypadEnabled;
}

- (void)setKeypadEnabled:(BOOL)aFlag {
	keypad(_window, aFlag ? TRUE : FALSE);
	_keypadEnabled = aFlag;
}

#pragma mark -
#pragma mark Attribute Methods
- (void)enableAttribute:(OCAttribute *)anAttribute {
	wattron(_window, [anAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(anAttribute.attributeIdentifier) : anAttribute.attributeIdentifier);
	[_attributes addObject:anAttribute];
}

- (void)disableAttribute:(OCAttribute *)anAttribute {
	wattroff(_window, [anAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(anAttribute.attributeIdentifier) : anAttribute.attributeIdentifier);
	[_attributes removeObject:anAttribute];
}

- (void)enableAttributes:(NSSet *)aSet {
	for (OCAttribute *attribute in aSet) {
		[self enableAttribute:attribute];
	}
}

- (void)disableAttributes:(NSSet *)aSet {
	for (OCAttribute *attribute in aSet) {
		[self disableAttribute:attribute];
	}
}

- (void)setAttributes:(NSSet *)aSet {
	unsigned int attributeSum = 0;
	for (OCAttribute *attribute in aSet) {
		attributeSum |= attribute.attributeIdentifier;
	}
	
	wattrset(_window, attributeSum);
	[_attributes autorelease], _attributes = [aSet copy];
}

- (void)disableAllAttributes {
	wattrset(_window, OCAttributeNormal);
	[_attributes autorelease], _attributes = [[NSMutableSet alloc] init];
}

#pragma mark -
#pragma mark Border Methods
- (OCBorder *)border {
	return _border;
}

- (void)setBorder:(OCBorder *)aBorder {
	if (_border != aBorder) {
		if (aBorder) {
			wborder(_window, aBorder.leftFill, aBorder.rightFill, aBorder.topFill, aBorder.bottomFill, aBorder.topLeftCorner, aBorder.topRightCorner, aBorder.bottomLeftCorner, aBorder.bottomRightCorner);
		} else {
			wborder(_window, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
		}
		
		[_border autorelease], _border = [aBorder retain];
	}
}

#pragma mark -
#pragma mark Printing Methods
- (void)clear {
	wclear(_window);
	wrefresh(_window);
}

- (BOOL)writeToWindow:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self writeToWindow:aFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self writeToWindowAtLocation:aLocation format:aFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindow:(NSString *)aFormat arguments:(va_list)aList {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self writeToWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:aFormat arguments:aList];
}

- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList {
	NSString *output = [[NSString alloc] initWithFormat:aFormat arguments:aList];
	int result = mvwprintw(_window, aLocation.y, aLocation.x, [output UTF8String]);
	[output release];
	
	return result == OK;
}

#pragma mark -
#pragma mark Character Methods
- (OCKey)getKey {
	return wgetch(_window);
}
- (OCKey)getKeyFromLocation:(NSPoint)aLocation {
	return mvwgetch(_window, aLocation.y, aLocation.x);
}

- (BOOL)writeCharacter:(OCCharacter)aCharacter {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self writeCharacterAtLocation:(NSPoint){xCoordinate, yCoordinate} character:aCharacter];
}

- (BOOL)writeCharacterAtLocation:(NSPoint)aLocation character:(OCCharacter)aCharacter {
	return mvwaddch(_window, aLocation.y, aLocation.x, aCharacter) == OK;
}

#pragma mark -
#pragma mark Scanning Methods
- (BOOL)scanFromWindow:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self scanFromWindow:aFormat arguments:aList], BOOL);
}

- (BOOL)scanFromWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self scanFromWindowAtLocation:aLocation format:aFormat arguments:aList], BOOL);
}

- (BOOL)scanFromWindow:(NSString *)aFormat arguments:(va_list)aList {
	int yCoordinate, xCoordinate;
	getyx(_window, yCoordinate, xCoordinate);
	return [self scanFromWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:aFormat arguments:aList];
}

- (BOOL)scanFromWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList {
	int result = wmove(_window, aLocation.y, aLocation.x);
	if (result == OK) {
		result = vwscanw(_window, (char *)[aFormat UTF8String], aList);
	}
	
	return result == OK;
}

#pragma mark - Is Equal
- (BOOL)isEqual:(id)object {
	if ([object isKindOfClass:[OCWindow class]]) {
		OCWindow *window = (OCWindow *)object;

		BOOL isEqual = NO;
		isEqual |= [window.title isEqualToString:_title];
		isEqual |= NSEqualRects(window->_frame, _frame);
		isEqual |= [window->_subwindows isEqual:_subwindows];
		isEqual |= [window->_attributes isEqual:_attributes];
		isEqual |= [window->_border isEqual:_border];
		isEqual |= window->_keypadEnabled == _keypadEnabled;
		isEqual |= window->_window == _window;
		isEqual |= window->_panel == _panel;
		return isEqual;
	} else {
		return NO;
	}
}

#pragma mark - Description
- (NSString *)description {
	return [NSString stringWithFormat:@"<OCWindow: %@, %@>", _title, NSStringFromRect(_frame)];
}

@end