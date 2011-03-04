//
//  OCCharacter.h
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

/*!
 @typedef OCCharacter
 @discussion A convenience typedef used for clarity.
 */
typedef unichar OCCharacter;

/*!
 Miscellaneous redefinitions of ncurses characters. This would be an enumeration if these characters
 were declared as constants (instead they are character mappings held in an array. Ugh.
 */
#define	OCCharacterUpperLeftCorner = ACS_ULCORNER		/* upper left corner */
#define	OCCharacterLowerLeftCorner = ACS_LLCORNER		/* lower left corner */
#define	OCCharacterUpperRightCorner = ACS_URCORNER		/* upper right corner */
#define	OCCharacterLowerRightCorner = ACS_LRCORNER		/* lower right corner */
#define	OCCharacterLeftTee = ACS_LTEE					/* tee pointing right */
#define	OCCharacterRightTee = ACS_RTEE					/* tee pointing left */
#define	OCCharacterBottomTee = ACS_BTEE					/* tee pointing up */
#define	OCCharacterTopTee = ACS_TTEE					/* tee pointing down */
#define	OCCharacterHorizontalLine = ACS_HLINE			/* horizontal line */
#define	OCCharacterVerticalLine = ACS_VLINE				/* vertical line */
#define	OCCharacterPlus = ACS_PLUS						/* large plus or crossover */
#define	OCCharacterScanLine1 = ACS_S1					/* scan line 1 */
#define	OCCharacterScanLine9 = ACS_S9					/* scan line 9 */
#define	OCCharacterDiamond = ACS_DIAMOND				/* diamond */
#define	OCCharacterCheckerboard = ACS_CKBOARD			/* checker board (stipple) */
#define	OCCharacterDegree = ACS_DEGREE					/* degree symbol */
#define	OCCharacterPlusMinus = ACS_PLMINUS				/* plus/minus */
#define	OCCharacterBullet = ACS_BULLET					/* bullet */
#define	OCCharacterLeftArrow = ACS_LARROW				/* arrow pointing left */
#define	OCCharacterRightArrow = ACS_RARROW				/* arrow pointing right */
#define	OCCharacterDownArrow = ACS_DARROW				/* arrow pointing down */
#define	OCCharacterUpArrow = ACS_UARROW					/* arrow pointing up */
#define	OCCharacterBoard = ACS_BOARD					/* board of squares */
#define	OCCharacterLantern = ACS_LANTERN				/* lantern symbol */
#define	OCCharacterBlock = ACS_BLOCK					/* solid square block */