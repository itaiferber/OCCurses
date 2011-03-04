//
//  OCKey.h
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

#include <curses.h>

/*!
 @typedef OCKey
 @discussion A convenience typedef used for clarity.
 */
typedef unichar OCKey;

/*!
 @enum OCKey
 @discussion A list of acceptable user keystrokes that ncurses accepts (given that keypad() is
 enabled) for processing.
 */
extern enum OCKey {
	OCKeyDown = KEY_DOWN,						/* down-arrow key */
	OCKeyUp = KEY_UP,							/* up-arrow key */
	OCKeyLeft = KEY_LEFT,						/* left-arrow key */
	OCKeyRight = KEY_RIGHT,						/* right-arrow key */
	OCKeyHome = KEY_HOME,						/* home key */
	OCKeyBackspace =  KEY_BACKSPACE,			/* backspace key */
	OCKeyFunction0 =  KEY_F0,					/* Function keys. Space for 64 */
	OCKeyDeleteLine = KEY_DL,					/* delete-line key */
	OCKeyInsertLine = KEY_IL,					/* insert-line key */
	OCKeyDeleteCharacter = KEY_DC,				/* insert-line key */
	OCKeyInsertCharacter = KEY_IC,				/* insert-character key */
	OCKeyEnterInsertMode = KEY_EIC,				/* sent by rmir or smir in insert mode */
	OCKeyClear = KEY_CLEAR,						/* clear-screen or erase key */
	OCKeyClearScreen = KEY_EOS,					/* clear-to-end-of-screen key */
	OCKeyClearLine = KEY_EOL,					/* clear-to-end-of-line key */
	OCKeyScrollForward = KEY_SF,				/* scroll-forward key */
	OCKeyScrollReverse = KEY_SR,				/* scroll-backward key */
	OCKeyNextPage = KEY_NPAGE,					/* next-page key */
	OCKeyPreviousPage = KEY_PPAGE,				/* previous-page key */
	OCKeySetTab = KEY_STAB,						/* set-tab key */
	OCKeyClearTab = KEY_CTAB,					/* clear-tab key */
	OCKeyClearAllTabs = KEY_CATAB,				/* clear-all-tabs key */
	OCKeyEnter = KEY_ENTER,						/* enter/send key */
	OCKeyPrint = KEY_PRINT,						/* print key */
	OCKeyHomeKeypad = KEY_LL,					/* lower-left key (home down) */
	OCKeyUpperLeftKeypad = KEY_A1,				/* upper left of keypad */
	OCKeyUpperRightKeypad = KEY_A3,				/* upper right of keypad */
	OCKeyCenterKeypad = KEY_B2,					/* center of keypad */
	OCKeyLowerLeftKeypad = KEY_C1,				/* lower left of keypad */
	OCKeyLowerRightKeypad = KEY_C3,				/* lower right of keypad */
	OCKeyBackTab = KEY_BTAB,					/* back-tab key */
	OCKeyBegin = KEY_BEG,						/* begin key */
	OCKeyCancel = KEY_CANCEL,					/* cancel key */
	OCKeyClose = KEY_CLOSE,						/* close key */
	OCKeyCommand = KEY_COMMAND,					/* command key */
	OCKeyCopy = KEY_COPY,						/* copy key */
	OCKeyCreate = KEY_CREATE,					/* create key */
	OCKeyEnd = KEY_END,							/* end key */
	OCKeyExit = KEY_EXIT,						/* exit key */
	OCKeyFind = KEY_FIND,						/* find key */
	OCKeyHelp = KEY_HELP,						/* help key */
	OCKeyMark = KEY_MARK,						/* mark key */
	OCKeyMessage = KEY_MESSAGE,					/* message key */
	OCKeyMove = KEY_MOVE,						/* move key */
	OCKeyNext = KEY_NEXT,						/* next key */
	OCKeyOpen = KEY_OPEN,						/* open key */
	OCKeyOptions = KEY_OPTIONS,					/* options key */
	OCKeyPrevious = KEY_PREVIOUS,				/* previous key */
	OCKeyRedo = KEY_REDO,						/* redo key */
	OCKeyReference = KEY_REFERENCE,				/* reference key */
	OCKeyRefresh = KEY_REFRESH,					/* refresh key */
	OCKeyReplace = KEY_REPLACE,					/* replace key */
	OCKeyRestart = KEY_RESTART,					/* restart key */
	OCKeyResume = KEY_RESUME,					/* resume key */
	OCKeySave = KEY_SAVE,						/* save key */
	OCKeyShiftedBegin = KEY_SBEG,				/* shifted begin key */
	OCKeyShiftedCancel = KEY_SCANCEL,			/* shifted cancel key */
	OCKeyShiftedCommand = KEY_SCOMMAND,			/* shifted command key */
	OCKeyShiftedCopy = KEY_SCOPY,				/* shifted copy key */
	OCKeyShiftedCreate = KEY_SCREATE,			/* shifted create key */
	OCKeyShiftedDeleteCharacter = KEY_SDC,		/* shifted delete-character key */
	OCKeyShiftedDeleteLine = KEY_SDL,			/* shifted delete-line key */
	OCKeySelect = KEY_SELECT,					/* select key */
	OCKeyShiftedEnd = KEY_SEND,					/* shifted end key */
	OCKeyShiftedClearLine = KEY_SEOL,			/* shifted clear-to-end-of-line key */
	OCKeyShiftedExit = KEY_SEXIT,				/* shifted exit key */
	OCKeyShiftedFind = KEY_SFIND,				/* shifted find key */
	OCKeyShiftedHelp = KEY_SHELP,				/* shifted help key */
	OCKeyShiftedHome = KEY_SHOME,				/* shifted home key */
	OCKeyShiftedInsertCharacter = KEY_SIC,		/* shifted insert-character key */
	OCKeyShiftedLeft = KEY_SLEFT,				/* shifted left-arrow key */
	OCKeyShiftedMessage = KEY_SMESSAGE,			/* shifted message key */
	OCKeyShiftedMove = KEY_SMOVE,				/* shifted move key */
	OCKeyShiftedNext = KEY_SNEXT,				/* shifted next key */
	OCKeyShiftedOptions = KEY_SOPTIONS,			/* shifted options key */
	OCKeyShiftedPrevious = KEY_SPREVIOUS,		/* shifted previous key */
	OCKeyShiftedPrint = KEY_SPRINT,				/* shifted print key */
	OCKeyShiftedRedo = KEY_SREDO,				/* shifted redo key */
	OCKeyShiftedReplace = KEY_SREPLACE,			/* shifted replace key */
	OCKeyShiftedRight = KEY_SRIGHT,				/* shifted right-arrow key */
	OCKeyShiftedResume = KEY_SRSUME,			/* shifted resume key */
	OCKeyShiftedSave = KEY_SSAVE,				/* shifted save key */
	OCKeyShiftedSuspend = KEY_SSUSPEND,			/* shifted suspend key */
	OCKeyShiftedUndo = KEY_SUNDO,				/* shifted undo key */
	OCKeySuspend = KEY_SUSPEND,					/* suspend key */
	OCKeyUndo = KEY_UNDO,						/* undo key */
	OCKeyMouse = KEY_MOUSE,						/* Mouse event has occurred */
	OCKeyResize = KEY_RESIZE,					/* Terminal resize event */
	OCKeyEvent = KEY_EVENT						/* We were interrupted by an event */
};

/*!
 A macro definition of a method for getting function keys mapped (valid up to OCKeyFunction(64)).
 */
#define OCKeyFunction(n) KEY_F(n)