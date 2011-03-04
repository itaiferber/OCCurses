//
//  OCWindow.m
//  OCCurses
//
//  Created by Itai Ferber on 3/2/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCWindow.h"

#define EVALUATE_WITH_ARGUMENT_LIST(format, argumentList, statement, returnType) va_list argumentList; \
																				  va_start(argumentList, format); \
																				  returnType result = statement; \
																				  va_end(argumentList); \
																				  return result;
#define UPDATE_PANELS update_panels(), doupdate()

@implementation OCWindow

#pragma mark Synthesis
@synthesize title;

#pragma mark -
#pragma mark Initialization
static OCWindow *mainWindow = nil;
+ (id)mainWindow {
	if (!mainWindow) {
		mainWindow = [[OCWindow alloc] init];
		mainWindow->title = nil;
		mainWindow->frame = (NSRect){0, 0, 0, 0};
		mainWindow->subwindows = [[NSMutableArray alloc] init];
		mainWindow->window = stdscr;
		mainWindow->panel = new_panel(stdscr);
	}
	
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
		window = newwin((int)frame.size.height, (int)frame.size.width, (int)frame.origin.y, (int)frame.origin.x);
		if (window != NULL) {
			title = [aTitle copy];
			frame = aFrame;
			subwindows = [[NSMutableArray alloc] init];
			attributes = [[NSMutableSet alloc] init];
			border = nil;
			
			panel = new_panel(window);
			[mainWindow addSubwindow:self];
			UPDATE_PANELS;
		} else {
			[self release], self = nil;
		}
	}
	
	return self;
}

- (id)initWithTitle:(NSString *)aTitle frame:(NSRect)aFrame parentWindow:(OCWindow *)aWindow {
	if ((self = [super init])) {
		window = newwin((int)frame.size.height, (int)frame.size.width, (int)frame.origin.y, (int)frame.origin.x);
		if (window != NULL) {
			title = [aTitle copy];
			frame = aFrame;
			subwindows = [[NSMutableArray alloc] init];
			attributes = [[NSMutableSet alloc] init];
			border = nil;
		
			panel = new_panel(window);
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
	[title release], title = nil;
	[subwindows release], subwindows = nil;
	[attributes release], attributes = nil;
	[border release], border = nil;
	
	delwin(window);
	del_panel(panel);
	[super dealloc];
}

#pragma mark -
#pragma mark Subwindow Methods
- (void)addSubwindow:(OCWindow *)aWindow {
	[subwindows addObject:aWindow];
}

- (OCWindow *)subwindowAtIndex:(NSUInteger)anIndex {
	return [subwindows objectAtIndex:anIndex];
}

- (OCWindow *)subwindowWithTitle:(NSString *)aTitle {
	for (OCWindow *subwindow in subwindows) {
		if ([subwindow.title isEqualToString:aTitle]) {
			return subwindow;
		}
	}
	
	for (OCWindow *subwindow in subwindows) {
		OCWindow *theWindow = [subwindow subwindowWithTitle:aTitle];
		if (theWindow) {
			return theWindow;
		}
	}
	
	return nil;
}

- (void)removeSubwindow:(OCWindow *)aWindow {
	[subwindows removeObject:aWindow];
}

#pragma mark -
#pragma mark Window Property Methods
- (NSRect)frame {
	return frame;
}

- (BOOL)setFrame:(NSRect)aRect {
	WINDOW *newWindow = newwin((int)aRect.size.height, (int)aRect.size.width, (int)aRect.origin.y, (int)aRect.origin.x);
	if (newWindow != NULL && mvwin(window, (int)aRect.origin.y, (int)aRect.origin.x) == OK) {
		overwrite(window, newWindow);
		replace_panel(panel, newWindow);
		delwin(window);
		window = newWindow;
	}
	
	return NO;
}

- (BOOL)setFrameOrigin:(NSPoint)aPoint {
	int result = move_panel(panel, aPoint.y, aPoint.x);
	if (result == OK) {
		frame.origin.x = aPoint.x;
		frame.origin.y = aPoint.y;
	}
	
	UPDATE_PANELS;
	return result == OK;
}

#pragma mark -
#pragma mark Attribute Methods
- (void)enableAttribute:(OCAttribute *)anAttribute {
	wattron(window, [anAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(anAttribute.attributeIdentifier) : anAttribute.attributeIdentifier);
	[attributes addObject:anAttribute];
}

- (void)disableAttribute:(OCAttribute *)anAttribute {
	wattroff(window, [anAttribute isKindOfClass:[OCColorPair class]] ? COLOR_PAIR(anAttribute.attributeIdentifier) : anAttribute.attributeIdentifier);
	[attributes removeObject:anAttribute];
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
	
	wattrset(window, attributeSum);
	[attributes autorelease], attributes = [aSet copy];
}

- (void)disableAllAttributes {
	wattrset(window, OCAttributeNormal);
	[attributes autorelease], attributes = [[NSMutableSet alloc] init];
}

#pragma mark -
#pragma mark Border Methods
- (OCBorder *)border {
	return border;
}

- (void)setBorder:(OCBorder *)aBorder {
	if (border != aBorder) {
		if (aBorder) {
			wborder(window, aBorder.leftFill, aBorder.rightFill, aBorder.topFill, aBorder.bottomFill, aBorder.topLeftCorner, aBorder.topRightCorner, aBorder.bottomLeftCorner, aBorder.bottomRightCorner);
		} else {
			wborder(window, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
		}
		
		[border autorelease], border = [aBorder retain];
	}
}

#pragma mark -
#pragma mark Printing Methods
- (BOOL)writeToWindow:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self writeToWindow:aFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat, ... {
	EVALUATE_WITH_ARGUMENT_LIST(aFormat, aList, [self writeToWindowAtLocation:aLocation format:aFormat arguments:aList], BOOL);
}

- (BOOL)writeToWindow:(NSString *)aFormat arguments:(va_list)aList {
	int yCoordinate, xCoordinate;
	getyx(window, yCoordinate, xCoordinate);
	return [self writeToWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:aFormat arguments:aList];
}

- (BOOL)writeToWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList {
	NSString *output = [[NSString alloc] initWithFormat:aFormat arguments:aList];
	int result = mvwprintw(window, aLocation.y, aLocation.x, [output UTF8String]);
	[output release];
	
	return result == OK;
}

#pragma mark -
#pragma mark Character Methods
- (OCKey)getKey {
	return wgetch(window);
}
- (OCKey)getKeyFromLocation:(NSPoint)aLocation {
	return mvwgetch(window, aLocation.y, aLocation.x);
}

- (BOOL)writeCharacter:(OCCharacter)aCharacter {
	int yCoordinate, xCoordinate;
	getyx(window, yCoordinate, xCoordinate);
	return [self writeCharacterAtLocation:(NSPoint){xCoordinate, yCoordinate} character:aCharacter];
}

- (BOOL)writeCharacterAtLocation:(NSPoint)aLocation character:(OCCharacter)aCharacter {
	return mvwaddch(window, aLocation.y, aLocation.x, aCharacter) == OK;
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
	getyx(window, yCoordinate, xCoordinate);
	return [self scanFromWindowAtLocation:(NSPoint){xCoordinate, yCoordinate} format:aFormat arguments:aList];
}

- (BOOL)scanFromWindowAtLocation:(NSPoint)aLocation format:(NSString *)aFormat arguments:(va_list)aList {
	int result = wmove(window, aLocation.y, aLocation.x);
	if (result == OK) {
		result = vwscanw(window, (char *)[aFormat UTF8String], aList);
	}
	
	return result == OK;
}

@end
