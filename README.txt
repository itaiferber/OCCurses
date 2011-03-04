OCCurses
by Itai Ferber - http://itaiferber.com

How to use OCCurses
===================

OCCurses is an Objective-C/Cocoa wrapper for the ncurses C library bundled with almost every installation of Unix. It
makes it easy to incorporate the power of ncurses into your command-line application without needing to delve into the
ncurses C interface.

The ncurses project is developed and maintained by the Free Software Foundation and the GNU Project. Read about it here:
http://www.gnu.org/software/ncurses/


Using OCCurses is easy. To link your project to the OCCurses framework, follow these steps:
1. Compile the OCCurses framework using whatever settings you wish.
2. Open up your application's Xcode project, and select the application target.
3. Hit 'Add' under the 'Link Binary With Libraries' heading, and add the compiled framework.
4. Add a new 'Copy Files' build phase that copies files to the 'Framework' folder (make sure there is no subpath).
5. Drag the framework to the build phase, and clean your project (for good measure).

To use the framework in your code:
1. Make sure you #import the OCCursesFramework.h header in whatever classes you wish to use the framework.
2. In the class that initializes your code, simply start using the framework! OCCursesManager automatically starts the
terminal in curses mode at program startup, so all you have to do is simply get to work (it will automatically exit
curses mode at program termination, so the environment is managed for you).


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

These steps are simplified with OCCurses:
1. Program initialization - handled automatically, but you can enable specific settings.
2. Initialize windows and panels - create OCWindow references and apply wanted attributes.
3. Use the windows and setup a runloop - print to the OCWindow's, reorder them, scan from them, etc.
4. Exit the program - handled automatically.


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
