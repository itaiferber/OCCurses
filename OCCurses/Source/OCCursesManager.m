//
//  OCCursesManager.m
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

#import "OCCursesManager.h"

@implementation OCCursesManager

#pragma mark - Initialization
#ifndef DEBUG
__attribute__((constructor))
void initialize () {
	initscr();	
	noraw();
	cbreak();
	noecho();
	halfdelay(0);
	
	inCursesMode = YES;
}

#pragma mark - Deallocation
__attribute__((destructor))
void deallocate () {
	endwin();
}
#endif

#pragma mark - State Methods
static BOOL inCursesMode = YES;
+ (BOOL)isInCursesMode {
	return inCursesMode;
}

+ (void)pauseCursesMode {
	if (inCursesMode) {
		def_prog_mode();
		endwin();
	}
}

+ (void)resumeCursesMode {
	if (!inCursesMode) {
		reset_prog_mode();
	}
}

+ (BOOL)hasColors {
	return has_colors();
}

+ (void)startColors {
	if (has_colors()) {
		start_color();
	}
}

#pragma mark - Terminal Settings
+ (BOOL)hasKey:(OCKey)aKey {
	return has_key(aKey) == OK;
}

static BOOL rawEnabled = NO;
+ (BOOL)isRawEnabled {
	return rawEnabled;
}

+ (void)setRawEnabled:(BOOL)aFlag {
	aFlag ? raw() : noraw();
	rawEnabled = aFlag;
}

static BOOL characterBreakEnabled = YES;
+ (BOOL)isCharacterBreakEnabled {
	return characterBreakEnabled;
}

+ (void)setCharacterBreakEnabled:(BOOL)aFlag {
	aFlag ? cbreak() : nocbreak();
	characterBreakEnabled = aFlag;
}

static BOOL echoEnabled = NO;
+ (BOOL)isEchoEnabled {
	return echoEnabled;
}

+ (void)setEchoEnabled:(BOOL)aFlag {
	aFlag ? echo() : noecho();
	echoEnabled = aFlag;
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