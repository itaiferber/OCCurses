//
//  OCCursesManager.m
//  OCCurses
//
//  Created by Itai Ferber on 3/3/11.
//  Copyright 2011 Itai Ferber. All rights reserved.
//

#import "OCCursesManager.h"


@implementation OCCursesManager

#pragma mark Initialization
static OCCursesManager *sharedManager = nil;
+ (id)sharedManager {
	if (!sharedManager) {
		sharedManager = [[OCCursesManager alloc] init];
	}
	
	return sharedManager;
}

- (id)init {
	if ((self = [super init])) {
		initscr();
		if (has_colors()) {
			start_color();
		}
		
		standardScreen = [OCWindow mainWindow];		
		[[self class] setCharacterBreakEnabled:YES];
		[[self class] setEchoEnabled:NO];
		[[self class] setKeypadEnabled:YES];
	}
	
	return self;
}

#pragma mark -
#pragma mark Deallocation
- (void)dealloc {
	endwin();
	[super dealloc];
}

#pragma mark -
#pragma mark Terminal Settings
+ (BOOL)hasKey:(OCKey)aKey {
	return has_key(aKey) == OK;
}

static BOOL isRawEnabled = NO;
+ (BOOL)isRawEnabled {
	return isRawEnabled;
}

+ (void)setRawEnabled:(BOOL)aFlag {
	aFlag ? raw() : noraw();
	isRawEnabled = aFlag;
}

static BOOL isCharacterBreakEnabled = NO;
+ (BOOL)isCharacterBreakEnabled {
	return isCharacterBreakEnabled;
}

+ (void)setCharacterBreakEnabled:(BOOL)aFlag {
	aFlag ? cbreak() : nocbreak();
	isCharacterBreakEnabled = aFlag;
}

static BOOL isEchoEnabled;
+ (BOOL)isEchoEnabled {
	return isEchoEnabled;
}

+ (void)setEchoEnabled:(BOOL)aFlag {
	aFlag ? echo() : noecho();
	isEchoEnabled = aFlag;
}

static BOOL isKeypadEnabled;
+ (BOOL)isKeypadEnabled {
	return isKeypadEnabled;
}

+ (void)setKeypadEnabled:(BOOL)aFlag {
	aFlag ? keypad(stdscr, TRUE) : keypad(stdscr, FALSE);
	isKeypadEnabled = aFlag;
}

static int halfDelay = 0;
+ (unsigned int)halfDelay {
	return halfDelay;
}

+ (void)setHalfDelay:(unsigned int)aDelay {
	halfdelay(aDelay);
	halfDelay = aDelay;
}

@end
