OCCurses
by Itai Ferber - http://itaiferber.com

How to use OCCurses
===================

OCCurses is an Objective-C/Cocoa wrapper for the ncurses C library bundled with almost every installation of Unix. It
makes it easy to incorporate the power of ncurses into your command-line application without needing to delve into the
ncurses C interface.

The ncurses project is developed and maintained by the Free Software Foundation and the GNU Project. Read about it here:
http://www.gnu.org/software/ncurses/


Using OCCurses is easy. The basic steps are:
1. Import the framework into your project with the appropriate steps.
2. In whatever class you're going to use OCCurses, make sure to #import the OCCursesFramework.h header file.
3. Instantiate an OCCursesManager using +[OCCursesManager sharedManager].
4. Create instances of OCWindow and get to work!


A note about ncurses
====================

If you are unfamiliar with the ncurses framework, it is a good idea that you read up on it before using OCCurses
blindly. There is an excellent tutorial for ncurses here (http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/), and it is
recommended that you look into it before starting a project.

A basic ncurses program follows a general runtime path like so:
1. Program initialization - call initscr() and terminal setting functions like cbreak().
2. Initialize windows and panels - create WINDOW* and PANEL* references.
3. Use the windows and setup a runloop - print to the WINDOW*'s and reorder the PANEL*'s, enable attributes, etc.
4. Exit the program - call endwin().

These steps are virtually the same with OCCurses:
1. Program initialization - call +[OCCursesManager sharedManager].
2. Initialize windows and panels - create OCWindow references.
3. Use the windows and setup a runloop - print to the OCWindow references, reorder them, enable attributes, etc.
4. Exit the program - let the shared manager autorelease.


That's it! Using OCCurses is very simple. If you have trouble with the code, or want to make a feature request or report
a bug (or evem contribute some improvements), you can get in touch with me using the info below. I hope you enjoy using
OCCurses!

Enjoy,
Itai Ferber

Web:        http://itaiferber.com
Email:      itaiferber@gmail.com
Twitter:    itaiferber

(README.txt shamelessly ripped as an example from the excellent Matt Legend Gemmell's MGTwitterEngine project. Props to
him for writing a thorough README file.)
